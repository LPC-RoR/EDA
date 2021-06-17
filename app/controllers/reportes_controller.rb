class ReportesController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_reporte, only: [:show, :edit, :update, :destroy, :xlsx]

  # GET /reportes
  # GET /reportes.json
  def index
    @coleccion = Reporte.all
  end

  # GET /reportes/1
  # GET /reportes/1.json
  def show
    @coleccion = {}
    @coleccion['carpetas'] = @objeto.carpetas
  end

  def xlsx
    # Construcción de la colección a desplegar
    ids_publicaciones = []
    @objeto.carpetas.each do |carpeta|
      ids_publicaciones = ids_publicaciones | carpeta.publicaciones.ids
    end

    @coleccion = {}
    @coleccion['publicaciones'] = Publicacion.where(id: ids_publicaciones.uniq)


    respond_to do |format|
      format.html
      format.xlsx
    end

    #redirect_to publicaciones_path
  end

  # GET /reportes/new
  def new
    @objeto = Reporte.new(proyecto_id: params[:objeto_id])
  end

  # GET /reportes/1/edit
  def edit
  end

  # POST /reportes
  # POST /reportes.json
  def create
    @objeto = Reporte.new(reporte_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Reporte was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reportes/1
  # PATCH/PUT /reportes/1.json
  def update
    respond_to do |format|
      if @objeto.update(reporte_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Reporte was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reportes/1
  # DELETE /reportes/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Reporte was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reporte
      @objeto = Reporte.find(params[:id])
    end

    def set_redireccion
      @redireccion = publicaciones_path
    end

    # Only allow a list of trusted parameters through.
    def reporte_params
      params.require(:reporte).permit(:reporte, :proyecto_id)
    end
end
