class Aplicacion::LicenciasController < ApplicationController
  before_action :set_licencia, only: [:show, :edit, :update, :destroy]

  # GET /licencias
  # GET /licencias.json
  def index
    @coleccion = Licencia.all
  end

  # GET /licencias/1
  # GET /licencias/1.json
  def show
  end

  # GET /licencias/new
  def new
    @objeto = Licencia.new
  end

  # GET /licencias/1/edit
  def edit
  end

  # POST /licencias
  # POST /licencias.json
  def create
    @objeto = Licencia.new(licencia_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Licencia was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /licencias/1
  # PATCH/PUT /licencias/1.json
  def update
    respond_to do |format|
      if @objeto.update(licencia_params)
        format.html { redirect_to @objeto, notice: 'Licencia was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /licencias/1
  # DELETE /licencias/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to licencias_url, notice: 'Licencia was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_licencia
      @objeto = Licencia.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def licencia_params
      params.require(:licencia).permit(:n_meses, :perfil_id)
    end
end
