class TemasController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_tema, only: [:show, :edit, :update, :destroy, :desasignar, :eliminar]

  # GET /temas
  # GET /temas.json
  def index
    proyecto_activo = Proyecto.find(session[:proyecto_activo]['id'])

    carpetas = proyecto_activo.carpetas_personalizadas
    @list_selector = carpetas.map {|car| [car.carpeta, car.temas.count]}
    # @objeto es la carpeta activa
    @objeto = params[:html_options].blank? ? carpetas.first : (params[:html_options]['sel'].blank? ? carpetas.first : carpetas.find_by(carpeta: params[:html_options]['sel']))

    @sel = @objeto.carpeta
    @options = {'sel' => @sel}

    @coleccion = {}
    @coleccion[controller_name] = @objeto.temas.order(:tema)
  end

  # GET /temas/1
  # GET /temas/1.json
  def show
    if params[:html_options].blank?
      @tab = 'referencia'
    else
      @tab = params[:html_options][:tab].blank? ? 'referencia' : params[:html_options][:tab]
    end
    @options = { 'tab' => @tab }
#    @estado = params[:estado].blank? ? @tab.classify.constantize::ESTADOS[0] : params[:estado]
    # tenemos que cubrir todos los casos
    # 1. has_many : }
    @coleccion = {}
    @coleccion['clasificaciones'] = @objeto.clasificaciones.where(clasificacion: @tab)
  end

  # GET /temas/new
  def new
    @objeto = Tema.new(perfil_id: session[:perfil_activo]['id'])
  end

  def nuevo
    unless params[:tema_base][:tema].blank?
      case params[:class_name]
      when 'Publicacion'
        publicacion = Publicacion.find(params[:objeto_id])
        unless params[:tema_base][:carpeta_id].blank?
          carpeta = Carpeta.find(params[:tema_base][:carpeta_id])
        end
      when 'Carpeta'
        carpeta = Carpeta.find(params[:objeto_id])
      end
    end

    unless carpeta.blank?
      unless carpeta.temas.map {|tema| tema.tema.downcase}.include?(params[:tema_base][:tema].strip)
        carpeta.temas.create(tema: params[:tema_base][:tema].strip)
      end
    end

    redirect_to temas_path if params[:class_name] == 'Carpeta'
    redirect_to publicacion if params[:class_name] == 'Publicacion'

  end

  # GET /temas/1/edit
  def edit
  end

  # POST /temas
  # POST /temas.json
  def create
    @objeto = Tema.new(tema_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Tema was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /temas/1
  # PATCH/PUT /temas/1.json
  def update
    respond_to do |format|
      if @objeto.update(tema_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Tema was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  def desasignar
    carpeta = Carpeta.find(params[:objeto_id])
    @objeto.carpetas.delete(carpeta)

    redirect_to temas_path
  end

  # DELETE /temas/1
  # DELETE /temas/1.json
  def destroy
    @objeto.destroy
    set_redireccion
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Tema was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def eliminar
    if @objeto.textos.empty?
      @objeto.delete
    end

    redirect_to temas_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tema
      @objeto = Tema.find(params[:id])
    end

    def set_redireccion
      @redireccion = temas_path
    end

    # Only allow a list of trusted parameters through.
    def tema_params
      params.require(:tema).permit(:tema)
    end
end
