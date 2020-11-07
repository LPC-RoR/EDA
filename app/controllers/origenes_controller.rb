class OrigenesController < ApplicationController
  before_action :set_origen, only: [:show, :edit, :update, :destroy]

  # GET /origenes
  # GET /origenes.json
  def index
    @origenes = Origen.all
  end

  # GET /origenes/1
  # GET /origenes/1.json
  def show
  end

  # GET /origenes/new
  def new
    @origen = Origen.new
  end

  # GET /origenes/1/edit
  def edit
  end

  # POST /origenes
  # POST /origenes.json
  def create
    @origen = Origen.new(origen_params)

    respond_to do |format|
      if @origen.save
        format.html { redirect_to @origen, notice: 'Origen was successfully created.' }
        format.json { render :show, status: :created, location: @origen }
      else
        format.html { render :new }
        format.json { render json: @origen.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /origenes/1
  # PATCH/PUT /origenes/1.json
  def update
    respond_to do |format|
      if @origen.update(origen_params)
        format.html { redirect_to @origen, notice: 'Origen was successfully updated.' }
        format.json { render :show, status: :ok, location: @origen }
      else
        format.html { render :edit }
        format.json { render json: @origen.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /origenes/1
  # DELETE /origenes/1.json
  def destroy
    @origen.destroy
    respond_to do |format|
      format.html { redirect_to origenes_url, notice: 'Origen was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_origen
      @origen = Origen.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def origen_params
      params.require(:origen).permit(:repositorio_id, :publicacion_id)
    end
end
