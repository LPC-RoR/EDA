class AlcancesController < ApplicationController
  before_action :set_alcance, only: [:show, :edit, :update, :destroy]

  # GET /alcances
  # GET /alcances.json
  def index
    @coleccion = Alcance.all
  end

  # GET /alcances/1
  # GET /alcances/1.json
  def show
  end

  # GET /alcances/new
  def new
    @objeto = Alcance.new
  end

  # GET /alcances/1/edit
  def edit
  end

  # POST /alcances
  # POST /alcances.json
  def create
    @objeto = Alcance.new(alcance_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Alcance was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alcances/1
  # PATCH/PUT /alcances/1.json
  def update
    respond_to do |format|
      if @objeto.update(alcance_params)
        format.html { redirect_to @objeto, notice: 'Alcance was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alcances/1
  # DELETE /alcances/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to alcances_url, notice: 'Alcance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alcance
      @objeto = Alcance.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def alcance_params
      params.require(:alcance).permit(:reporte_id, :carpeta_id)
    end
end
