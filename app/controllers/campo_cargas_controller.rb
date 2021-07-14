class CampoCargasController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_campo_carga, only: [:show, :edit, :update, :destroy]

  # GET /campo_cargas
  # GET /campo_cargas.json
  def index
    @coleccion = CampoCarga.all
  end

  # GET /campo_cargas/1
  # GET /campo_cargas/1.json
  def show
  end

  # GET /campo_cargas/new
  def new
    formato_carga = FormatoCarga.find(params[:formato_carga_id])
    @objeto = formato_carga.campo_cargas.new
  end

  # GET /campo_cargas/1/edit
  def edit
  end

  # POST /campo_cargas
  # POST /campo_cargas.json
  def create
    @objeto = CampoCarga.new(campo_carga_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Campo carga was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campo_cargas/1
  # PATCH/PUT /campo_cargas/1.json
  def update
    respond_to do |format|
      if @objeto.update(campo_carga_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Campo carga was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campo_cargas/1
  # DELETE /campo_cargas/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Campo carga was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campo_carga
      @objeto = CampoCarga.find(params[:id])
    end

    def set_redireccion
      @redireccion = @objeto.formato_carga
    end

    # Only allow a list of trusted parameters through.
    def campo_carga_params
      params.require(:campo_carga).permit(:campo_carga, :campo_tabla, :formato_carga_id)
    end
end
