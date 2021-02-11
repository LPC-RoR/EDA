class PublicacionesController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_publicacion, only: [:show, :edit, :update, :destroy, :cambia_evaluacion]

  after_action :procesa_author, only: [:update, :create]
  after_action :procesa_journal, only: [:update, :create]
  after_action :procesa_estado, only: [:update, :create]
  after_action :procesa_doi, only: [:update, :create]

  # GET /publicaciones
  # GET /publicaciones.json
  def index
    @activo = Perfil.find(session[:perfil_activo]['id'])

    # BI FRAME
    @frame_selector = @activo.carpetas.all.map {|c| [c.carpeta, c.publicaciones.count]}
    # carpeta
    if params[:html_options].blank?
      @carpeta = @activo.carpetas.first
    else
      @carpeta = params[:html_options]['sel'].blank? ? @activo.carpetas.first : @activo.carpetas.find_by(carpeta: params[:html_options]['sel'])
    end
    @sel = @carpeta.carpeta
    # opciones para los links
    @options = {'sel' => @sel}

    @coleccion = {}
    @coleccion[controller_name] = @carpeta.publicaciones.page(params[:page])

  end

  # GET /publicaciones/1
  # GET /publicaciones/1.json
  def show
    # ********************** DUPLICADOS *****************************

    @duplicados_doi_ids = @objeto.doi.present? ? (Publicacion.where(doi: @objeto.doi).ids - [@objeto.id]) : []
    @duplicados_t_sha1_ids = @objeto.title.present? ? (Publicacion.where(t_sha1: @objeto.t_sha1).ids - [@objeto.id]) : []

    @duplicados_ids = @duplicados_doi_ids.union(@duplicados_t_sha1_ids)

    unless @duplicados_ids.empty?
      @duplicados = Publicacion.where(id: @duplicados_ids)
    end

    # *********************** CARPETAS ******************************
    @activo = Perfil.find(session[:perfil_activo]['id'])

    ## AMBOS
    @ids_carpetas_base = @activo.carpetas.map {|c| c.id if Carpeta::NOT_MODIFY.include?(c.carpeta)}.compact
    @ids_carpetas_tema = @activo.carpetas.map {|c| c.id unless Carpeta::NOT_MODIFY.include?(c.carpeta)}.compact

    # ids de las carpetas del @activo
    ids_activo = @ids_carpetas_base | @ids_carpetas_tema

    # ids de la publicación que son del perfil
    ids_publicacion = @objeto.carpetas.ids & ids_activo

    id_carpeta_carga      = @activo.carpetas.find_by(carpeta: 'Carga').id
    id_carpeta_ingreso    = @activo.carpetas.find_by(carpeta: 'Ingreso').id
    id_carpeta_duplicados = @activo.carpetas.find_by(carpeta: 'Duplicados').id

    @id_carpeta_revisadas  = @activo.carpetas.find_by(carpeta: 'Revisadas').id

    ids_tres   = @activo.carpetas.where(carpeta: ['Carga', 'Ingreso', 'Duplicados']).ids
    ids_cuatro = @activo.carpetas.where(carpeta: ['Carga', 'Ingreso', 'Duplicados', 'Revisadas']).ids

    ids_todas = @ids_carpetas_base | @ids_carpetas_tema

    if ids_publicacion.empty?
      ids_seleccion = (@ids_carpetas_base - ids_tres)
    elsif ids_publicacion.include?(id_carpeta_duplicados)
      ids_seleccion = @objeto.origen == 'ingreso' ? ['Ingreso'] : ['Carga']
    elsif (ids_publicacion.include?(id_carpeta_ingreso) or ids_publicacion.include?(id_carpeta_carga))
      ids_seleccion = (@ids_carpetas_base - ids_tres)
    elsif (ids_publicacion.include?(@id_carpeta_revisadas) and ((ids_publicacion & @ids_carpetas_tema).empty?))
      ids_seleccion = ids_todas - ids_cuatro
    elsif (@ids_carpetas_tema & ids_publicacion).any?
      ids_seleccion = @ids_carpetas_tema - ids_publicacion
    else
      ids_seleccion = @ids_carpetas_base - (ids_tres | (@ids_carpetas_base & ids_publicacion))
    end

    @carpetas_seleccion = Carpeta.find(ids_seleccion)

    # ***************************************** @show_colection[Modelo]
    @coleccion = {}
    @coleccion['textos']   = @objeto.textos
    @coleccion['temas']    = @perfil.temas
    @coleccion['carpetas'] = @objeto.carpetas

  end

  # GET /publicaciones/new
  def new
    @activo = Perfil.find(session[:perfil_activo]['id'])
    @objeto = @activo.ingresos.new(origen: 'ingreso', estado: 'ingreso')
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
    @activo = Perfil.find(session[:perfil_activo]['id'])
    @publicacion = Publicacion.find(params[:publicacion_id])

    if params[:estado] == 'eliminado'
      @publicacion.delete
    elsif params[:estado] == 'correccion'
      if @publicacion.perfil.id == session[:perfil_activo]['id']
        # Sólo se procesan publicaciones 'ingreso' propias
        @publicacion.estado = 'ingreso'
        @publicacion.unicidad = 'unico'
        @publicacion.save
        # Hay que asegurarse que sacamos la publicación Sólo de nuestras carpetas
        carpetas_ids = @publicacion.carpetas.ids.intersection(@activo.carpetas.ids)
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

      carpeta_ingreso = @activo.carpetas.find_by(carpeta: 'Ingreso')
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

    def set_publicacion
      @objeto = Publicacion.find(params[:id])
    end

    def set_redireccion
      @redireccion = @objeto
    end

    # Only allow a list of trusted parameters through.
    def publicacion_params
      params.require(:publicacion).permit(:unique_id, :origen, :title, :author, :doi, :year, :volume, :pages, :month, :publisher, :abstract, :link, :author_email, :issn, :eissn, :address, :affiliation, :article_number, :keywords, :keywords_plus, :research_areas, :web_of_science_categories, :da, :d_journal, :d_author, :d_doi, :registro_id, :revista_id, :equipo_id, :investigador_id, :academic_degree, :estado, :book, :doc_type, :editor, :ciudad_pais, :journal, :perfil_id)
    end
end
