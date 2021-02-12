class ProyectosController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_proyecto, only: [:show, :edit, :update, :destroy]

  # GET /proyectos
  # GET /proyectos.json
  def index
    @activo = Perfil.find(session[:perfil_activo]['id'])

    if params[:html_options].blank?
      @tab = 'Administrados'
    else
      @tab = params[:html_options][:tab].blank? ? 'Administrados' : params[:html_options][:tab]
    end
    @options = {'tab' => @tab}

    @coleccion = {}
    @coleccion[controller_name] = (@tab == 'Administrados') ? @activo.proyectos : @activo.colaboraciones

  end

  # GET /proyectos/1
  # GET /proyectos/1.json
  def show
    @activo = Perfil.find(session[:perfil_activo]['id'])
    if params[:html_options].blank?
      @tab = 'temas'
    else
      @tab = params[:html_options][:tab].blank? ? 'temas' : params[:html_options][:tab]
    end
    @options = { 'tab' => @tab }
#    @estado = params[:estado].blank? ? @tab.classify.constantize::ESTADOS[0] : params[:estado]
    # tenemos que cubrir todos los casos
    # 1. has_many : }
    @coleccion = {}
    @coleccion['perfiles']  = @objeto.perfiles
    @coleccion['versiones'] = @objeto.versiones
    @coleccion['temas']     = @objeto.temas
    @coleccion['etapas']    = @objeto.etapas
  end

  # GET /proyectos/new
  def new
    @objeto = Proyecto.new
  end

  def nuevo
    unless params[:nuevo_proyecto][:proyecto].blank?
      @activo = Perfil.find(session[:perfil_activo]['id'])

      case params[:tab]
      when 'Administrados'
        @texto_sha1 = session[:perfil_activo]['email']+params[:nuevo_proyecto][:proyecto]
        @sha1 = Digest::SHA1.hexdigest(@texto_sha1)
        @activo.proyectos.create(proyecto: params[:nuevo_proyecto][:proyecto], sha1: @sha1)
      when 'Participaciones'
        @sha1 = params[:nuevo_proyecto][:proyecto]
        @proyecto = Proyecto.find_by(sha1: @sha1)
        unless @proyecto.blank?
          @perfil.asociaciones << @proyecto
        end
      end
    end
    redirect_to "/proyectos?tab=#{params[:tab]}"
  end

  def nuevo_tema_proyecto
    @proyecto = Proyecto.find(params[:proyecto_id])
    @tema     = Tema.find(params[:tema_base][:tema_id])
    @proyecto.temas << @tema unless @proyecto.temas.ids.include?(@tema.id)

    redirect_to @proyecto
  end

  # GET /proyectos/1/edit
  def edit
  end

  # POST /proyectos
  # POST /proyectos.json
  def create
    @objeto = Proyecto.new(proyecto_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Proyecto was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proyectos/1
  # PATCH/PUT /proyectos/1.json
  def update
    respond_to do |format|
      if @objeto.update(proyecto_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Proyecto was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proyectos/1
  # DELETE /proyectos/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Proyecto was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proyecto
      @objeto = Proyecto.find(params[:id])
    end

    def set_redireccion
      @redireccion = '/proyectos'
    end

    # Only allow a list of trusted parameters through.
    def proyecto_params
      params.require(:proyecto).permit(:proyecto, :sha1, :administrador_id)
    end
end
