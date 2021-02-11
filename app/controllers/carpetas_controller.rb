class CarpetasController < ApplicationController
  before_action :inicia_sesion
  before_action :authenticate_usuario!
  before_action :carga_temas_ayuda
  before_action :set_carpeta, only: [:show, :edit, :update, :destroy, :remueve_carpeta]

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
    @tab = params[:tab].blank? ? 'publicaciones' : params[:tab]
#    @estado = params[:estado].blank? ? @tab.classify.constantize::ESTADOS[0] : params[:estado]
    # tenemos que cubrir todos los casos
    # 1. has_many : }
    @coleccion = {}
    @coleccion[@tab] = @objeto.send(@tab).page(params[:page]) #.where(estado: @estado)
  end

  # GET /carpetas/new
  def new
    @objeto = Carpeta.new(perfil_id: session[:perfil_activo]['id'])
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

  def asigna
    @activo = Perfil.find(session[:perfil_activo]['id'])

    publicacion = Publicacion.find(params[:publicacion_id])

    unless params[:carpeta_base][:carpeta_id].blank?
      carpeta     = Carpeta.find(params[:carpeta_base][:carpeta_id])

      ids_carpetas_base = @activo.carpetas.map {|c| c.id if Carpeta::NOT_MODIFY.include?(c.carpeta)}.compact
      ids_carpetas_tema = @activo.carpetas.map {|c| c.id unless Carpeta::NOT_MODIFY.include?(c.carpeta)}.compact
      ids_activo = (ids_carpetas_base | ids_carpetas_tema)
      ids_publicacion = publicacion.carpetas.ids & ids_activo

      if ids_carpetas_base.include?(params[:carpeta_base][:carpeta_id].to_i)
        publicacion.carpetas.each do |cpta|
          publicacion.carpetas.delete(cpta)
        end
      end
      publicacion.carpetas << carpeta
    end

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

  def remueve_carpeta
    publicacion = Publicacion.find(params[:objeto_id])
    @objeto.publicaciones.delete(publicacion)

    redirect_to publicacion
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carpeta
      @objeto = Carpeta.find(params[:id])
    end

    def set_redireccion
      @redireccion = "/carpetas"
    end

    # Only allow a list of trusted parameters through.
    def carpeta_params
      params.require(:carpeta).permit(:carpeta, :perfil_id)
    end
end
