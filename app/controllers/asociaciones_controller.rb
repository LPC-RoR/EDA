class AsociacionesController < ApplicationController
  before_action :set_asociacion, only: [:show, :edit, :update, :destroy]

  # GET /asociaciones
  # GET /asociaciones.json
  def index
    @asociaciones = Asociacion.all
  end

  # GET /asociaciones/1
  # GET /asociaciones/1.json
  def show
  end

  # GET /asociaciones/new
  def new
    @asociacion = Asociacion.new
  end

  # GET /asociaciones/1/edit
  def edit
  end

  # POST /asociaciones
  # POST /asociaciones.json
  def create
    @asociacion = Asociacion.new(asociacion_params)

    respond_to do |format|
      if @asociacion.save
        format.html { redirect_to @asociacion, notice: 'Asociacion was successfully created.' }
        format.json { render :show, status: :created, location: @asociacion }
      else
        format.html { render :new }
        format.json { render json: @asociacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asociaciones/1
  # PATCH/PUT /asociaciones/1.json
  def update
    respond_to do |format|
      if @asociacion.update(asociacion_params)
        format.html { redirect_to @asociacion, notice: 'Asociacion was successfully updated.' }
        format.json { render :show, status: :ok, location: @asociacion }
      else
        format.html { render :edit }
        format.json { render json: @asociacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asociaciones/1
  # DELETE /asociaciones/1.json
  def destroy
    @asociacion.destroy
    respond_to do |format|
      format.html { redirect_to asociaciones_url, notice: 'Asociacion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asociacion
      @asociacion = Asociacion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asociacion_params
      params.require(:asociacion).permit(:publicacion_id, :proyecto_id)
    end
end
