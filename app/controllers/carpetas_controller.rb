class CarpetasController < ApplicationController
  before_action :inicia_sesion
  before_action :authenticate_usuario!
  before_action :carga_temas_ayuda
  before_action :set_carpeta, only: [:show, :edit, :update, :destroy, :desasigna_carpeta, :elimina_carpeta, :btn_asigna, :sacar_carpeta]

  # GET /carpetas
  # GET /carpetas.json
  def index
    @activo = Perfil.find(session[:perfil_activo]['id'])

    @coleccion = {}
    @coleccion[controller_name] = @activo.carpetas
  end

  def seleccion
    @link_seleccion = "/textos/new?publicacion_id=#{params[:publicacion_id]}&carpeta_id="
    @coleccion = Carpeta.all
  end

  # GET /carpetas/1
  # GET /carpetas/1.json
  def show
    @coleccion = {}
    @coleccion['publicaciones'] = @objeto.publicaciones.page(params[:page]) #.where(estado: @estado)
  end

  # GET /carpetas/new
  def new
    proyecto_activo = Proyecto.find(session[:proyecto_activo]['id'])
    @objeto = Carpeta.new(perfil_id: session[:perfil_activo]['id'], proyecto_id: proyecto_activo.id)
  end

  def nuevo
    publicacion = Publicacion.find(params[:objeto_id])
    unless params[:nueva_carpeta][:carpeta].blank?
      proyecto_activo = Proyecto.find(session[:proyecto_activo]['id'])

      nombres_carpetas = proyecto_activo.carpetas.map {|car| car.carpeta.downcase}
      unless nombres_carpetas.include?(params[:nueva_carpeta][:carpeta].downcase)
        proyecto_activo.carpetas.create(carpeta: params[:nueva_carpeta][:carpeta])
      end
    end
    redirect_to "/publicaciones/#{publicacion.id}?tab=Proceso"
  end

  def nueva_carpeta_reporte
    unless params[:carpeta_base][:carpeta_id].blank?
      reporte = Reporte.find(params[:reporte_id])
      carpeta = Carpeta.find(params[:carpeta_base][:carpeta_id])
      
      reporte.carpetas << carpeta
    end

    redirect_to reporte
  end

  # GET /carpetas/1/edit
  def edit
  end

  # POST /carpetas
  # POST /carpetas.json
  def create
    @objeto = Carpeta.new(carpeta_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Carpeta was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carpetas/1
  # PATCH/PUT /carpetas/1.json
  def update
    respond_to do |format|
      if @objeto.update(carpeta_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Carpeta was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  def btn_asigna
    proyecto_activo = Proyecto.find(session[:proyecto_activo]['id'])
    publicacion = Publicacion.find(params[:publicacion_id])

    ids_carpetas_base = proyecto_activo.carpetas_seleccion.ids

    if ids_carpetas_base.include?(@objeto.id) or (publicacion.carpetas.count == 1 and publicacion.carpetas.first.carpeta == 'Aceptadas')
      publicacion.carpetas.delete_all
    end
    publicacion.carpetas << @objeto

    redirect_to publicacion
  end

  def desasigna_carpeta
    publicacion = Publicacion.find(params[:objeto_id])
    @objeto.publicaciones.delete(publicacion)

    redirect_to publicacion
  end

  # DELETE /carpetas/1
  # DELETE /carpetas/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Carpeta was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Elimina carpetas del proyecto, la borrq sólo si no tiene publicaciones
  def elimina_carpeta
    publicacion = Publicacion.find(params[:objeto_id])
    if @objeto.temas.empty?
      @objeto.publicaciones.delete_all
      @objeto.delete
    end
    redirect_to publicacion
  end

  # Saca carpeta del reporte
  def sacar_carpeta
    reporte = Reporte.find(params[:objeto_id])
    unless reporte.blank?
      @objeto.reportes.delete(reporte)
    end
    redirect_to reporte
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carpeta
      @objeto = Carpeta.find(params[:id])
    end

    def set_redireccion
      @redireccion = '/proyectos/proyecto_activo'
    end

    # Only allow a list of trusted parameters through.
    def carpeta_params
      params.require(:carpeta).permit(:carpeta, :perfil_id, :proyecto_id)
    end
end
