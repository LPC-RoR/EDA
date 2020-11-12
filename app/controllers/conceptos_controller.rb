class ConceptosController < ApplicationController
  before_action :set_concepto, only: [:show, :edit, :update, :destroy]

  # GET /conceptos
  # GET /conceptos.json
  def index
    @coleccion = Concepto.all
  end

  # GET /conceptos/1
  # GET /conceptos/1.json
  def show
  end

  # GET /conceptos/new
  def new
    @objeto = Concepto.new
  end

  # GET /conceptos/1/edit
  def edit
  end

  # POST /conceptos
  # POST /conceptos.json
  def create
    @objeto = Concepto.new(concepto_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Concepto was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conceptos/1
  # PATCH/PUT /conceptos/1.json
  def update
    respond_to do |format|
      if @objeto.update(concepto_params)
        format.html { redirect_to @objeto, notice: 'Concepto was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conceptos/1
  # DELETE /conceptos/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to conceptos_url, notice: 'Concepto was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_concepto
      @objeto = Concepto.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def concepto_params
      params.require(:concepto).permit(:concepto)
    end
end
