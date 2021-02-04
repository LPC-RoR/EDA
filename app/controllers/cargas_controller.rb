class CargasController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :set_carga, only: [:show, :edit, :update, :destroy, :procesa_carga]

  # GET /cargas
  # GET /cargas.json
  def index
    @activo = Perfil.find(session[:perfil_activo]['id'])

    @coleccion = {}
    @coleccion[controller_name] = @activo.cargas

    user_dir = session[:es_administrador] == true ? 'admin' : archivo_usuario(current_usuario.email)
    dir_path = "#{Rails.root}/archivos/#{user_dir}/#{controller_name}/"
    @dir = File.dirname("#{dir_path}**")
    FileUtils.mkdir_p(@dir) unless File.directory?(@dir)

    @archivos = Dir.glob("#{@dir}/**") - @activo.cargas.map {|c| c.archivo}

  end

  def sel_archivo
    @activo = Perfil.find(session[:perfil_activo]['id'])
    @archivos = Dir.glob("#{Configuracion::RUTA_ARCHIVOS['cargas']}**/*") - @activo.cargas.map {|c| c.archivo}
  end

  # GET /cargas/1
  # GET /cargas/1.json
  def show
    @tab = params[:tab].blank? ? 'publicaciones' : params[:tab]
#    @estado = params[:estado].blank? ? @tab.classify.constantize::ESTADOS[0] : params[:estado]
    # tenemos que cubrir todos los casos
    # 1. has_many : }
    @coleccion = @objeto.send(@tab).page(params[:page]) #.where(estado: @estado)
  end

  def procesa_carga

    if @objeto.estado == 'ingreso'
      # Abre archivo
      carga_archivo_bib(@objeto)

#      @objeto.estado = 'procesada'
#      @objeto.save
    end

    redirect_to cargas_path
  end # def

  # GET /cargas/new
  def new
    @objeto = Carga.new(estado: 'ingreso', perfil_id: session[:perfil_activo]['id'])
  end

  # GET /cargas/1/edit
  def edit
  end

  # POST /cargas
  # POST /cargas.json
  def create
    @objeto = Carga.new(carga_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Carga was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cargas/1
  # PATCH/PUT /cargas/1.json
  def update
    respond_to do |format|
      if @objeto.update(carga_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Carga was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cargas/1
  # DELETE /cargas/1.json
  def destroy
    @objeto.destroy
    set_redireccion
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Carga was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carga
      @objeto = Carga.find(params[:id])
    end

    def set_redireccion
      @redireccion = '/cargas'
    end

    # Only allow a list of trusted parameters through.
    def carga_params
      params.require(:carga).permit(:archivo, :nota, :estado, :perfil_id, :archivo_carga, :archivo_carga_cache)
    end
end
