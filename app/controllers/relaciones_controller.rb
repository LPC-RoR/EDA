class RelacionesController < ApplicationController
  before_action :set_relacion, only: [:show, :edit, :update, :destroy]

  # GET /relaciones
  # GET /relaciones.json
  def index
    @relaciones = Relacion.all
  end

  # GET /relaciones/1
  # GET /relaciones/1.json
  def show
  end

  # GET /relaciones/new
  def new
    @relacion = Relacion.new
  end

  # GET /relaciones/1/edit
  def edit
  end

  # POST /relaciones
  # POST /relaciones.json
  def create
    @relacion = Relacion.new(relacion_params)

    respond_to do |format|
      if @relacion.save
        format.html { redirect_to @relacion, notice: 'Relacion was successfully created.' }
        format.json { render :show, status: :created, location: @relacion }
      else
        format.html { render :new }
        format.json { render json: @relacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /relaciones/1
  # PATCH/PUT /relaciones/1.json
  def update
    respond_to do |format|
      if @relacion.update(relacion_params)
        format.html { redirect_to @relacion, notice: 'Relacion was successfully updated.' }
        format.json { render :show, status: :ok, location: @relacion }
      else
        format.html { render :edit }
        format.json { render json: @relacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /relaciones/1
  # DELETE /relaciones/1.json
  def destroy
    @relacion.destroy
    respond_to do |format|
      format.html { redirect_to relaciones_url, notice: 'Relacion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_relacion
      @relacion = Relacion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def relacion_params
      params.require(:relacion).permit(:parent_id, :child_id)
    end
end
