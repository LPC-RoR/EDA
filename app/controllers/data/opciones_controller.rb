class Data::OpcionesController < ApplicationController
  before_action :carga_temas_ayuda
  before_action :set_opcion, only: [:show, :edit, :update, :destroy]

  # GET /opciones
  # GET /opciones.json
  def index
    @coleccion = Opcion.all
  end

  # GET /opciones/1
  # GET /opciones/1.json
  def show
  end

  # GET /opciones/new
  def new
    @objeto = Opcion.new
  end

  # GET /opciones/1/edit
  def edit
  end

  # POST /opciones
  # POST /opciones.json
  def create
    @objeto = Opcion.new(opcion_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Opcion was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opciones/1
  # PATCH/PUT /opciones/1.json
  def update
    respond_to do |format|
      if @objeto.update(opcion_params)
        format.html { redirect_to @objeto, notice: 'Opcion was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opciones/1
  # DELETE /opciones/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to opciones_url, notice: 'Opcion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opcion
      @objeto = Opcion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def opcion_params
      params.require(:opcion).permit(:opcion, :caracteristica_id)
    end
end
