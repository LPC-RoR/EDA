class ProyectosController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_proyecto, only: [:show, :edit, :update, :destroy, :activo]

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
    @coleccion[controller_name] = (@tab == 'Administrados') ? @activo.proyectos.order(:proyecto) : @activo.colaboraciones.order(:proyecto)

  end

  def proyecto_activo
    @activo = Perfil.find(session[:perfil_activo]['id'])

    @objeto = Proyecto.find(session[:proyecto_activo].id)

    @temas_seleccion = Tema.where(id: (@activo.temas.ids - @objeto.temas.ids)).order(:tema)
    @temas_proyecto = @objeto.temas.order(:tema)

    # tenemos que cubrir todos los casos
    # 1. has_many : }
    @coleccion = {}
    @coleccion['perfiles']  = @objeto.perfiles
    @coleccion['versiones'] = @objeto.versiones
    @coleccion['temas']     = @objeto.temas
    @coleccion['etapas']    = @objeto.etapas
    @coleccion['carpetas']  = @objeto.carpetas

  end

  # GET /proyectos/1
  # GET /proyectos/1.json
  def show
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
    @activo = Perfil.find(session[:perfil_activo]['id'])
#    @publicacion   = Publicacion.find(params[:publicacion_id])

    unless params[:nuevo_tema][:tema].strip.blank?
      nuevo_tema = params[:nuevo_tema][:tema].strip
  
      tema_perfil = @activo.temas.find_by(tema: nuevo_tema)
      if tema_perfil.blank?
        @proyecto.temas.create(tema: nuevo_tema, perfil_id: @activo.id)
      else
        tema_proyecto = @proyecto.temas.find_by(tema: nuevo_tema)
        if tema_proyecto.blank?
          @proyecto.temas << tema_perfil
        end
      end
    end

    redirect_to '/proyectos/proyecto_activo'

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

  def asigna_tema_proyecto
    @proyecto = Proyecto.find(params[:proyecto_id])
    @tema     = Tema.find(params[:tema_base][:tema_id])
    @proyecto.temas << @tema unless @proyecto.temas.ids.include?(@tema.id)

    redirect_to '/proyectos/proyecto_activo'
  end

  def activo
    proyectos_activos = Proyecto.where(activo: true)
    unless proyectos_activos.empty?
      proyectos_activos.each do |proyecto|
        proyecto.activo = false
        proyecto.save
      end
    end
    @objeto.activo = true
    @objeto.save
    redirect_to proyectos_path
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

  def elimina_tema_proyecto
    @proyecto = Proyecto.find(params[:proyecto_id])
    @tema     = Tema.find(params[:tema_base][:tema_id])
    if @tema.proyectos.empty? and @tema.textos.empty?
      @tema.delete
    end

    redirect_to '/proyectos/proyecto_activo'
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
