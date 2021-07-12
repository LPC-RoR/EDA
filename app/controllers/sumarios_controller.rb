class SumariosController < ApplicationController
  before_action :set_sumario, only: [:show, :edit, :update, :destroy]

  # GET /sumarios
  # GET /sumarios.json
  def index
    @sumarios = Sumario.all
  end

  # GET /sumarios/1
  # GET /sumarios/1.json
  def show
  end

  # GET /sumarios/new
  def new
    @sumario = Sumario.new
  end

  # GET /sumarios/1/edit
  def edit
  end

  # POST /sumarios
  # POST /sumarios.json
  def create
    @sumario = Sumario.new(sumario_params)

    respond_to do |format|
      if @sumario.save
        format.html { redirect_to @sumario, notice: 'Sumario was successfully created.' }
        format.json { render :show, status: :created, location: @sumario }
      else
        format.html { render :new }
        format.json { render json: @sumario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sumarios/1
  # PATCH/PUT /sumarios/1.json
  def update
    respond_to do |format|
      if @sumario.update(sumario_params)
        format.html { redirect_to @sumario, notice: 'Sumario was successfully updated.' }
        format.json { render :show, status: :ok, location: @sumario }
      else
        format.html { render :edit }
        format.json { render json: @sumario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sumarios/1
  # DELETE /sumarios/1.json
  def destroy
    @sumario.destroy
    respond_to do |format|
      format.html { redirect_to sumarios_url, notice: 'Sumario was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sumario
      @sumario = Sumario.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sumario_params
      params.require(:sumario).permit(:clave, :valor, :encabezado_id)
    end
end
