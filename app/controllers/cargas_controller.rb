class CargasController < ApplicationController
  before_action :set_carga, only: [:show, :edit, :update, :destroy]

  # GET /cargas
  # GET /cargas.json
  def index
    @coleccion = Carga.all
  end

  # GET /cargas/1
  # GET /cargas/1.json
  def show
  end

  # GET /cargas/new
  def new
    @objeto = Carga.new(archivo: params[:archivo], estado: 'ingreso')
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
        format.html { redirect_to @objeto, notice: 'Carga was successfully created.' }
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
        format.html { redirect_to @objeto, notice: 'Carga was successfully updated.' }
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
    respond_to do |format|
      format.html { redirect_to cargas_url, notice: 'Carga was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carga
      @objeto = Carga.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def carga_params
      params.require(:carga).permit(:archivo, :nota, :estado)
    end
end
