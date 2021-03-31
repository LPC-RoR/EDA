class Data::EncabezadosController < ApplicationController
  before_action :set_encabezado, only: [:show, :edit, :update, :destroy]

  # GET /encabezados
  # GET /encabezados.json
  def index
    @coleccion = Encabezado.all
  end

  # GET /encabezados/1
  # GET /encabezados/1.json
  def show
  end

  # GET /encabezados/new
  def new
    @objeto = Encabezado.new
  end

  # GET /encabezados/1/edit
  def edit
  end

  # POST /encabezados
  # POST /encabezados.json
  def create
    @objeto = Encabezado.new(encabezado_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Encabezado was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /encabezados/1
  # PATCH/PUT /encabezados/1.json
  def update
    respond_to do |format|
      if @objeto.update(encabezado_params)
        format.html { redirect_to @objeto, notice: 'Encabezado was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /encabezados/1
  # DELETE /encabezados/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to encabezados_url, notice: 'Encabezado was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_encabezado
      @objeto = Encabezado.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def encabezado_params
      params.require(:encabezado).permit(:orden, :encabezado, :tipo)
    end
end
