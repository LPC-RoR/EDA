class OrigenesController < ApplicationController
  before_action :set_origen, only: [:show, :edit, :update, :destroy]

  # GET /origenes
  # GET /origenes.json
  def index
    @coleccion = Origen.all
  end

  # GET /origenes/1
  # GET /origenes/1.json
  def show
  end

  # GET /origenes/new
  def new
    @objeto = Origen.new
  end

  # GET /origenes/1/edit
  def edit
  end

  # POST /origenes
  # POST /origenes.json
  def create
    @objeto = Origen.new(origen_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Origen was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /origenes/1
  # PATCH/PUT /origenes/1.json
  def update
    respond_to do |format|
      if @objeto.update(origen_params)
        format.html { redirect_to @objeto, notice: 'Origen was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /origenes/1
  # DELETE /origenes/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to origenes_url, notice: 'Origen was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_origen
      @objeto = Origen.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def origen_params
      params.require(:origen).permit(:repositorio_id, :publicacion_id)
    end
end
