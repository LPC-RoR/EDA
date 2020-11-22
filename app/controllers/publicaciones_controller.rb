class PublicacionesController < ApplicationController
  before_action :set_publicacion, only: [:show, :edit, :update, :destroy]

  # GET /publicaciones
  # GET /publicaciones.json
  def index
    @tab = params[:tab].blank? ? 'Revisar' : params[:tab]
    @carpeta = Carpeta.find_by(carpeta: @tab)
    if @carpeta.blank?
      Carpeta.create(carpeta: 'Revisar')
    end
    @coleccion = @carpeta.publicaciones.page(params[:page])
  end

  # GET /publicaciones/1
  # GET /publicaciones/1.json
  def show
    @tab = params[:tab].blank? ? 'textos' : params[:tab]
#    @estado = params[:estado].blank? ? @tab.classify.constantize::ESTADOS[0] : params[:estado]
    # tenemos que cubrir todos los casos
    # 1. has_many : }
    @coleccion = @objeto.send(@tab).page(params[:page]) #.where(estado: @estado)
  end

  # GET /publicaciones/new
  def new
    @objeto = Publicacion.new
  end

  def mask_new
  end
  def mask_nuevo
    @origen = 'ingreso'
    @title = params[:m_params][:title].strip
    @author = procesa_autores(params[:m_params][:author].strip)

    @revista = procesa_editorial(params[:m_params][:journal])[:journal].strip
    @r = Revista.find_by(revista: @revista)
    if @r.blank?
      @r = Revista.create(revista: @revista)
    end

    @journal_id = @r.id
    @volume = procesa_editorial(params[:m_params][:journal])[:volume].strip
    @year = procesa_editorial(params[:m_params][:journal])[:year].strip
    @pages = procesa_editorial(params[:m_params][:journal])[:pages].strip
    @doi = params[:m_params][:doi].strip
    @abstract = params[:m_params][:abstract].strip
    @objeto = Publicacion.create(origen: @origen, title: @title, author: @author, revista_id: @journal_id, volume: @volume, year: @year, pages: @pages, doi: @doi, abstract: @abstract)

    @investigadores = @author.split(' & ')
    @investigadores.each do |i|
      @i = Investigador.find_by(investigador: i)
      if @a.blank?
        @i = Investigador.create(investigador: i)
      end
      @objeto.investigadores << @i
    end

    redirect_to '/publicaciones'
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
    @origen = Carpeta.find_by(carpeta: params[:origen])
    @destino = Carpeta.find_by(carpeta: params[:destino])
    @publicacion = Publicacion.find(params[:publicacion_id])
    @clasificacion = Clasificacion.find_by(carpeta_id: @origen.id, publicacion_id: @publicacion.id)

    @clasificacion.delete 
    @destino.publicaciones << @publicacion

    redirect_to "/publicaciones?tab=#{@origen.carpeta}"
  end

  def cambia_evaluacion
    @publicacion = Publicacion.find(params[:publicacion_id])
    @evaluacion = @publicacion.evaluaciones.find_by(aspecto: params[:item])
    if @evaluacion.blank?
      @publicacion.evaluaciones.create(aspecto: params[:item], evaluacion: params[:evaluacion])
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
