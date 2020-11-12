class ReferenciasController < ApplicationController
  before_action :set_referencia, only: [:show, :edit, :update, :destroy]

  # GET /referencias
  # GET /referencias.json
  def index
    @coleccion = Referencia.all
  end

  # GET /referencias/1
  # GET /referencias/1.json
  def show
  end

  # GET /referencias/new
  def new
    @objeto = Referencia.new
  end

  # GET /referencias/1/edit
  def edit
  end

  # POST /referencias
  # POST /referencias.json
  def create
    @objeto = Referencia.new(referencia_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Referencia was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /referencias/1
  # PATCH/PUT /referencias/1.json
  def update
    respond_to do |format|
      if @objeto.update(referencia_params)
        format.html { redirect_to @objeto, notice: 'Referencia was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /referencias/1
  # DELETE /referencias/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to referencias_url, notice: 'Referencia was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_referencia
      @objeto = Referencia.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def referencia_params
      params.require(:referencia).permit(:concepto_id, :publicacion_id)
    end
end
