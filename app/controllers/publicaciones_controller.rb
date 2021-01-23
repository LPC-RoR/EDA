class PublicacionesController < ApplicationController
  before_action :authenticate_usuario!
  before_action :set_publicacion, only: [:show, :edit, :update, :destroy]

  # GET /publicaciones
  # GET /publicaciones.json
  def index
    # BI FRAME
    # Lista de 'selectors'
    @activo = Perfil.find(session[:perfil_activo]['id'])
    @frame_selector = @activo.carpetas.all.map {|c| [c.carpeta, c.publicaciones.count]}
    # CONTROLADOR de la tabla a desplegar
    @table_controller = 'publicaciones'

    # carpeta
    if params[:html_options].blank?
      @carpeta = @activo.carpetas.first
    else
      @carpeta = params[:html_options]['sel'].blank? ? @activo.carpetas.first : @activo.carpetas.find_by(carpeta: params[:html_options]['sel'])
    end

    # selector activo
    @sel = @carpeta.carpeta
    # opciones para los links
    @options = {'sel' => @sel}

    @coleccion = @carpeta.publicaciones.page(params[:page])
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

    # ********************** DUPLICADOS *****************************
    @activo = Perfil.find(session[:perfil_activo]['id'])
    # Aqui me gano los porotos. El manejo de carpetas
    # Voy a hacer dos columnas
    # IZQ las carpetas en las cuales la Publicacion está
    # DER las carpetas en las que se puede agregar
    # CARPETAS EN LAS QUE ESTÁ (Propias + Equipo)
    # 1.- los ids de las carpetas de @activo se dividen en @carpetas_base @carpetas_tema
    @ids_carpetas_base = @activo.carpetas.map {|c| c.id if Carpeta::NOT_MODIFY.include?(c.carpeta)}.compact
    @ids_carpetas_tema = @activo.carpetas.map {|c| c.id unless Carpeta::NOT_MODIFY.include?(c.carpeta)}.compact

    @id_carpeta_revisadas = @activo.carpetas.find_by(carpeta: 'Revisadas').id
    # QUE GACEMOS CON LAS CARPETAS DE LOS EQUIPOS A LOS QUE PERTENECEMOS ??
    # HAREMOS EL PERFIL DEL USUARIO E IMPLEMENTAREMOS BOTONES PARA CAMBIAR DE PERFIL

    # Tomamos de las carpetas de la publicacion SOLO las que pertenecen a SELF
    @ids_carpetas_publicacion = @objeto.carpetas.ids.intersection(@activo.carpetas.ids) 

    @ids_actual_base = @ids_carpetas_base.intersection(@ids_carpetas_publicacion)
    @ids_actual_tema = @ids_carpetas_tema.intersection(@ids_carpetas_publicacion)

    # El primer caso es cuando NO esta en NINGUNA CARPETA
    if @ids_carpetas_publicacion.empty?
      @carpetas_actuales  = nil
      @carpetas_destino = Carpeta.where(id: @ids_carpetas_base)
    elsif @ids_actual_tema.empty?
      # En este caso tenemos dos casos distintos 
      # 1.- El tema es "Revisada" ? Se pueden agregar carpetas Personalizadas
      # 2.- Otro tema : Solo se puede cambiar de Carpeta base
      if @ids_actual_base.include?(@id_carpeta_revisadas)
        @carpetas_actuales = Carpeta.where(id: @ids_actual_base)
        @carpetas_destino  = Carpeta.where(id: @ids_carpetas_base.union(@ids_carpetas_tema) - @ids_actual_base)
      else
        @carpetas_actuales = Carpeta.where(id: @ids_actual_base)
        @carpetas_destino  = Carpeta.where(id: @ids_carpetas_base - @ids_actual_base)
      end
    else
      # En este caso SOLO se pueden AGREGAR o QUITAR Carpetas TEMA
      @carpetas_actuales = Carpeta.where(id: @ids_actual_base.union(@ids_actual_tema))
      @carpetas_destino  = Carpeta.where(id: @ids_carpetas_tema - @ids_actual_tema)
    end

#    @tab = 'instancias'
#    @tl_coleccion = @objeto.instancias
#    @options = {'tab' => @tab}
      

#    @tab = params[:tab].blank? ? 'textos' : params[:tab]
#    @estado = params[:estado].blank? ? @tab.classify.constantize::ESTADOS[0] : params[:estado]
    # tenemos que cubrir todos los casos
    # 1. has_many : }
#    @coleccion = @objeto.send(@tab).page(params[:page]) #.where(estado: @estado)

  end

  # GET /publicaciones/new
  def new
    @objeto = Publicacion.new
  end

  def mask_new
    @origen = params[:origen]
  end
  def mask_nuevo
    @origen = params[:origen] == 'equipos' ? 'Produccion' : 'Manual'

    # TITULO
    @title = params[:m_params][:title].strip
    # AUTORES
    @author = procesa_autores(params[:m_params][:author].strip)
    # REVISTA
    @revista = procesa_editorial(params[:m_params][:journal])[:journal].strip
    @r = Revista.find_by(revista: @revista)
    if @r.blank?
      @r = Revista.create(revista: @revista)
    end

    @journal_id = @r.id
    # VOLUMEN
    @volume = procesa_editorial(params[:m_params][:journal])[:volume].strip
    # YEAR
    @year = procesa_editorial(params[:m_params][:journal])[:year].strip
    # PAGES
    @pages = procesa_editorial(params[:m_params][:journal])[:pages].strip
    # DOI
    @doi = params[:m_params][:doi].strip
    # ABSTRACT
    @abstract = params[:m_params][:abstract].strip
    @objeto = Publicacion.create(origen: @origen, title: @title, author: @author, revista_id: @journal_id, volume: @volume, year: @year, pages: @pages, doi: @doi, abstract: @abstract)
    # Procesa AUTORES
    @investigadores = @author.split(' & ')
    @investigadores.each do |i|
      @i = Investigador.find_by(investigador: i)
      if @a.blank?
        @i = Investigador.create(investigador: i)
      end
      @objeto.investigadores << @i
    end
    # A Publicaciones del Equipo : equipo#show si origen == 'equipos'
    # A recursos#tablas si origen == 'recursos'
    if @origen == 'equipos'
      @equipo = Equipo.find(session[:equipo_id])
      @equipo.publicaciones << @objeto
      redirect_to @equipo
    elsif @origen == 'Manual'
      @investigador = Investigador.find(params[:perfil]['id'])
      @carpeta = @investigador.carpetas.find_by(carpeta: 'Revisar')
      @carpeta.publicaciones << @objeto
      redirect_to "/recursos/tablas"
    end
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
        format.html { redirect_to @objeto, notice: 'Publicacion was successfully created.' }
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
        format.html { redirect_to @objeto, notice: 'Publicacion was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  def cambia_carpeta
    @activo = Perfil.find(session[:perfil_activo]['id'])
    @objeto = Publicacion.find(params[:html_options][:publicacion_id])
    @carpeta = Carpeta.find(params[:html_options][:carpeta_id])

    @ids_carpetas_base = @activo.carpetas.map {|c| c.id if Carpeta::NOT_MODIFY.include?(c.carpeta)}.compact
    @ids_carpetas_tema = @activo.carpetas.map {|c| c.id unless Carpeta::NOT_MODIFY.include?(c.carpeta)}.compact

    @id_carpeta_revisadas = @activo.carpetas.find_by(carpeta: 'Revisadas').id

    @ids_carpetas_publicacion = @objeto.carpetas.ids.intersection(@activo.carpetas.ids) 

    @ids_actual_base = @ids_carpetas_base.intersection(@ids_carpetas_publicacion)
    @ids_actual_tema = @ids_carpetas_tema.intersection(@ids_carpetas_publicacion)

    case params[:html_options][:origen]
    when 'actuales'
      # En este caso sólo tienen link las carpetas tema y lo único que hay que hacer es eliminarlas
      @objeto.carpetas.delete(@carpeta)
    when 'destinos'
      if @ids_carpetas_base.include?(params[:html_options][:carpeta_id].to_i)
        @cars = Carpeta.where(id: @ids_actual_base)
        @cars.each do |cc|
          @objeto.carpetas.delete(cc)
        end
      end
      @objeto.carpetas << @carpeta
    end

    redirect_to @objeto

  end

  def cambia_evaluacion
    @activo = Perfil.find(session[:perfil_activo]['id'])
    @publicacion = Publicacion.find(params[:publicacion_id])
    @evaluacion = @publicacion.evaluaciones.find_by(aspecto: params[:item], perfil_id: @activo.id)
    if @evaluacion.blank?
      @publicacion.evaluaciones.create(aspecto: params[:item], evaluacion: params[:evaluacion], perfil_id: @activo.id)
    else
      @evaluacion.evaluacion = params[:evaluacion]
      @evaluacion.save
    end
    redirect_to @publicacion
    
  end

  # DELETE /publicaciones/1
  # DELETE /publicaciones/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to publicaciones_url, notice: 'Publicacion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publicacion
      @objeto = Publicacion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def publicacion_params
      params.require(:publicacion).permit(:titulo, :detalle_autores, :detalle_revista, :keywords, :detalle_instituciones, :fechas, :doi, :annio, :paginas, :link, :abstract, :registro_id, :revista_id)
    end
end
