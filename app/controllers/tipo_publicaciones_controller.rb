class TipoPublicacionesController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_tipo_publicacion, only: [:show, :edit, :update, :destroy]

  # GET /tipo_publicaciones
  # GET /tipo_publicaciones.json
  def index
    @coleccion = TipoPublicacion.all
  end

  # GET /tipo_publicaciones/1
  # GET /tipo_publicaciones/1.json
  def show
    @tabs = ['Campos', 'Ejemplo']
    if params[:html_options].blank?
      @tab = 'Campos'
    else
      @tab = params[:html_options][:tab].blank? ? 'Campos' : params[:html_options][:tab]
    end
    @options = {'tab' => @tab}

    if @tab == 'Campos'
      @coleccion = {}
      @coleccion['campos'] = @objeto.campos.order(:orden)
    end
  end

  # GET /tipo_publicaciones/new
  def new
    @objeto = TipoPublicacion.new
  end

  # GET /tipo_publicaciones/1/edit
  def edit
  end

  # POST /tipo_publicaciones
  # POST /tipo_publicaciones.json
  def create
    @objeto = TipoPublicacion.new(tipo_publicacion_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Tipo publicacion was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipo_publicaciones/1
  # PATCH/PUT /tipo_publicaciones/1.json
  def update
    respond_to do |format|
      if @objeto.update(tipo_publicacion_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Tipo publicacion was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_publicaciones/1
  # DELETE /tipo_publicaciones/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Tipo publicacion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_publicacion
      @objeto = TipoPublicacion.find(params[:id])
    end

    def set_redireccion
      @redireccion = '/recursos/administracion'
    end

    # Only allow a list of trusted parameters through.
    def tipo_publicacion_params
      params.require(:tipo_publicacion).permit(:tipo_publicacion, :redireccion, :ejemplo)
    end
end
