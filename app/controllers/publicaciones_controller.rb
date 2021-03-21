class PublicacionesController < ApplicationController

  include ProcesaCarga

  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_publicacion, only: [:show, :edit, :update, :destroy, :cambia_evaluacion]

  after_action :procesa_author, only: [:update, :create]
  after_action :procesa_journal, only: [:update, :create]
  after_action :procesa_estado, only: [:update, :create]
  after_action :procesa_doi, only: [:update, :create]
  after_action :asigna_proyecto_activo, only: [:create]

  # GET /publicaciones
  # GET /publicaciones.json
  def index
    proyecto_activo = Proyecto.find(session[:proyecto_activo]['id'])

    @tab = params[:html_options].blank? ? 'Selección' : (params[:html_options]['tab'].blank? ? 'Selección' : params[:html_options]['tab'])
    carpetas = (@tab == 'Selección' ? proyecto_activo.carpetas_seleccion : proyecto_activo.carpetas_proceso)
    @list_selector = carpetas.map {|car| [car.carpeta, car.publicaciones.count]}
    carpeta = params[:html_options].blank? ? carpetas.first : (params[:html_options]['sel'].blank? ? carpetas.first : carpetas.find_by(carpeta: params[:html_options]['sel']))
    carpeta = carpetas.first if carpeta.blank?

    @sel = carpeta.carpeta
    @options = {'sel' => @sel, 'tab' => @tab}

    @coleccion = {}
    @coleccion[controller_name] = carpeta.publicaciones.page(params[:page])
  end

  # GET /publicaciones/1
  # GET /publicaciones/1.json
  def show
    # ********************** DUPLICADOS *****************************

    @duplicados = @objeto.duplicados

    # *********************** CARPETAS ******************************
    proyecto_activo = Proyecto.find(session[:proyecto_activo]['id'])

    if @objeto.en_seleccion?
      # publicaciones por seleccionar -> primer destino
      @carpetas_seleccion = proyecto_activo.carpetas_primer_destino
    elsif @objeto.primer_destino?
      # Publicaciones en primer destino -> Carpetas de Seleccion + Origen
      @carpetas_seleccion = proyecto_activo.carpetas_seleccionados_menos_activa_mas_origen(@objeto)
    elsif @objeto.en_proceso?
      @carpetas_seleccion = proyecto_activo.carpetas_todas_menos_activa_mas_origen(@objeto)
    elsif @objeto.procesada?
      @carpetas_seleccion = proyecto_activo.carpetas_de_proceso(@objeto)
    end

    @carpetas_creacion_temas = proyecto_activo.carpetas.where.not(carpeta: Carpeta::NOT_MODIFY)

    # ***************************************** @show_colection[Modelo]
    @coleccion = {}
    @coleccion['textos']   = @objeto.textos
#    @coleccion['temas']    = proyecto_activo.temas
    @coleccion['carpetas'] = @objeto.carpetas

    @temas_seleccion = proyecto_activo.temas_seleccion

  end

  # GET /publicaciones/new
  def new
    proyecto_activo = Proyecto.find(session[:proyecto_activo]['id'])
    @objeto = proyecto_activo.publicaciones.new(origen: 'ingreso', estado: 'ingreso')
  end

  # GET /publicaciones/1/edit
  def edit
  end

  # POST /publicaciones
  # POST /publicaciones.json
  def create
    @objeto = Publicacion.new(publicacion_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Publicacion was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /publicaciones/1
  # PATCH/PUT /publicaciones/1.json
  def update
    respond_to do |format|
      if @objeto.update(publicacion_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Publicacion was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  def cambia_tipo
    @publicacion = Publicacion.find(params[:publicacion_id])
    @publicacion.doc_type = params[:doc_type]
    @publicacion.save

    redirect_to @publicacion
  end

  def cambia_evaluacion
    @activo = Perfil.find(session[:perfil_activo]['id'])
#    @objeto = Publicacion.find(params[:publicacion_id])

    @evaluacion = @objeto.evaluaciones.find_by(aspecto: params[:item], perfil_id: @activo.id)
    if @evaluacion.blank?
      @objeto.evaluaciones.create(aspecto: params[:item], evaluacion: params[:evaluacion], perfil_id: @activo.id)
    else
      @evaluacion.evaluacion = params[:evaluacion]
      @evaluacion.save
    end
    redirect_to @objeto
    
  end

  def estado
    @publicacion = Publicacion.find(params[:publicacion_id])
    proyecto_activo = Proyecto.find(session[:proyecto_activo]['id'])

    if params[:estado] == 'eliminado'
      @publicacion.delete
    elsif params[:estado] == 'correccion'
      if @publicacion.perfil.id == session[:perfil_activo]['id']
        # Sólo se procesan publicaciones 'ingreso' propias
        @publicacion.estado = 'ingreso'
        @publicacion.unicidad = 'unico'
        @publicacion.save
        # Hay que asegurarse que sacamos la publicación Sólo de nuestras carpetas
        carpetas_ids = @publicacion.carpetas.ids.intersection(proyecto_activo.carpetas.ids)
        carpetas_ids.each do |car_id|
          carpeta_a_limpiar = Carpeta.find(car_id)
          @publicacion.carpetas.delete(carpeta_a_limpiar)
        end

        investigadores_ids = @publicacion.investigadores.ids
        investigadores_ids.each do |inv_id|
          inv = Investigador.find(inv_id)
          @publicacion.investigadores.delete(inv)
          unless inv.publicaciones.any?
            inv.delete
          end
        end
        revista = @publicacion.revista
        revista.publicaciones.delete(@publicacion)
        if revista.publicaciones.count == 0
          revista.delete
        end

        @publicacion.evaluaciones.delete_all
      end
    elsif params[:estado] == 'multiple'
      @publicacion.estado = 'publicada'
      @publicacion.unicidad = 'multiple'
      @publicacion.save
    else
      @publicacion.estado = params[:estado]
      @publicacion.save
    end

    if @publicacion.estado == 'publicada'
      # Publicamos las publicaciones INGRESO
      procesa_ingreso(@publicacion)
      @publicacion.estado = 'publicada'
      @publicacion.save

      carpeta_ingreso = proyecto_activo.carpetas.find_by(carpeta: 'Ingreso')
      carpeta_ingreso.publicaciones << @publicacion
    end

    redirect_to (@publicacion.origen == 'ingreso' ? @publicacion : publicaciones_path)
  end

  # DELETE /publicaciones/1
  # DELETE /publicaciones/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Publicacion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def procesa_author
      if @objeto.d_author.present?
        @objeto.author = limpia_autor_ingreso(@objeto.d_author)
        @objeto.save
      end
    end

    def procesa_sha1
      unless @objeto.title.blank?
        @t_sha1 = Digest::SHA1.hexdigest(@objeto.title.downcase)
        unless @objeto.t_sha1 == @t_sha1
          @objeto.t_sha1 = @t_sha1
          @objeto.save
        end
      end
    end

    def procesa_journal
      # Puede estar el volumen antes o despues del año
      if @objeto.d_journal.present?
        match_year = @objeto.d_journal.strip.match(/(?<anterior>[^\(]*) \((?<year>\d{4})\) (?<siguiente>.*)/)
        anterior = match_year[:anterior].strip
        siguiente = match_year[:siguiente].strip
        if !!anterior.match(/\d+/)
          # la revista tienen el volumen
          match_journal_volume = anterior.strip.match(/(?<journal>\D*) (?<volume>\d*)/)
          @objeto.journal = match_journal_volume[:journal].strip
          @objeto.volume = match_journal_volume[:volume].strip
          @objeto.pages = siguiente
        else
          @objeto.journal = anterior

          if siguiente.split(':').length == 2
            @objeto.volume = siguiente.split(':')[0].strip
            @objeto.pages = siguiente.split(':')[1].strip
          elsif siguiente.split(',').length == 2
            @objeto.volume = siguiente.split(',')[0].strip
            @objeto.pages = siguiente.split(',')[1].strip
          else
            @objeto.volume = ''
            @objeto.pages = siguiente
          end
        end
        @objeto.year = match_year[:year]

        @objeto.save
      end
    end

    def procesa_estado
      procesa_sha1
      @duplicados_doi_ids = @objeto.doi.present? ? (Publicacion.where(doi: @objeto.doi).ids - [@objeto.id]) : []
      @duplicados_t_sha1_ids = @objeto.title.present? ? (Publicacion.where(t_sha1: @objeto.t_sha1).ids - [@objeto.id]) : []

      @duplicados_ids = @duplicados_doi_ids.union(@duplicados_t_sha1_ids)

      if @duplicados_ids.empty?
        if @objeto.estado == 'duplicado'
          @objeto.estado = @objeto.origen == 'carga' ? 'carga' : 'ingreso'
          @objeto.save
        end
      else
        if @objeto.unicidad == 'multiple'
          @objeto.estado = @objeto.origen == 'carga' ? 'carga' : 'ingreso'
        else
          @objeto.estado = 'duplicado'
        end
        @objeto.save
      end
    end

    def procesa_doi
      if @objeto.d_doi.present?
        primer_filtro_doi = @objeto.d_doi.strip.delete_prefix('DOI').delete_prefix('doi:').strip
        @objeto.doi = !!primer_filtro_doi.match(/doi.org/) ? primer_filtro_doi.strip.split('doi.org/')[1] : primer_filtro_doi
        @objeto.save
      end
    end

    def asigna_proyecto_activo
      proyecto_activo = Proyecto.find(session[:proyecto_activo]['id'])
      proyecto_activo.publicaciones << @objeto
    end

    def set_publicacion
      @objeto = Publicacion.find(params[:id])
    end

    def set_redireccion
      @redireccion = @objeto
    end

    # Only allow a list of trusted parameters through.
    def publicacion_params
      params.require(:publicacion).permit(:unique_id, :origen, :title, :author, :doi, :year, :volume, :pages, :month, :publisher, :abstract, :link, :author_email, :issn, :eissn, :address, :affiliation, :article_number, :keywords, :keywords_plus, :research_areas, :web_of_science_categories, :da, :d_journal, :d_author, :d_doi, :registro_id, :revista_id, :equipo_id, :investigador_id, :academic_degree, :estado, :book, :doc_type, :editor, :ciudad_pais, :journal)
    end
end
