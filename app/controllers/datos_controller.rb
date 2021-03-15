class DatosController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_dato, only: [:show, :edit, :update, :destroy]

  # GET /datos
  # GET /datos.json
  def index
    @proyecto_activo = session[:proyecto_activo]

    @etapas = @proyecto_activo.etapas.order(:orden)
  end

  # GET /datos/1
  # GET /datos/1.json
  def show
  end

  # GET /datos/new
  def new
    @objeto = Dato.new
  end

  # GET /datos/1/edit
  def edit
  end

  # POST /datos
  # POST /datos.json
  def create
    @objeto = Dato.new(dato_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Dato was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /datos/1
  # PATCH/PUT /datos/1.json
  def update
    respond_to do |format|
      if @objeto.update(dato_params)
        format.html { redirect_to @objeto, notice: 'Dato was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /datos/1
  # DELETE /datos/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to datos_url, notice: 'Dato was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dato
      @objeto = Dato.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dato_params
      params.fetch(:dato, {})
    end
end
