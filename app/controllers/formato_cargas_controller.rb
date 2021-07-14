class FormatoCargasController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_formato_carga, only: [:show, :edit, :update, :destroy]

  # GET /formato_cargas
  # GET /formato_cargas.json
  def index
    @coleccion = FormatoCarga.all
  end

  # GET /formato_cargas/1
  # GET /formato_cargas/1.json
  def show
    @coleccion = {}
    @coleccion['campo_cargas'] = @objeto.campo_cargas.order(:campo_carga)
  end

  # GET /formato_cargas/new
  def new
    @objeto = FormatoCarga.new
  end

  # GET /formato_cargas/1/edit
  def edit
  end

  # POST /formato_cargas
  # POST /formato_cargas.json
  def create
    @objeto = FormatoCarga.new(formato_carga_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Formato carga was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /formato_cargas/1
  # PATCH/PUT /formato_cargas/1.json
  def update
    respond_to do |format|
      if @objeto.update(formato_carga_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Formato carga was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /formato_cargas/1
  # DELETE /formato_cargas/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Formato carga was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_formato_carga
      @objeto = FormatoCarga.find(params[:id])
    end

    def set_redireccion
      @redireccion = administracion_recursos_path
    end

    # Only allow a list of trusted parameters through.
    def formato_carga_params
      params.require(:formato_carga).permit(:formato_carga)
    end
end
