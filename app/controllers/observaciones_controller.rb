class ObservacionesController < ApplicationController
  before_action :carga_temas_ayuda
  before_action :set_observacion, only: [:show, :edit, :update, :destroy]

  # GET /observaciones
  # GET /observaciones.json
  def index
    @coleccion = Observacion.all
  end

  # GET /observaciones/1
  # GET /observaciones/1.json
  def show
  end

  # GET /observaciones/new
  def new
    padre = Linea.find(params[:linea_id]) unless params[:linea_id].blank?
    padre = Tabla.find(params[:tabla_id]) unless params[:tabla_id].blank?

    @objeto = padre.observaciones.new
  end

  # GET /observaciones/1/edit
  def edit
  end

  # POST /observaciones
  # POST /observaciones.json
  def create
    @objeto = Observacion.new(observacion_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Observacion was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /observaciones/1
  # PATCH/PUT /observaciones/1.json
  def update
    respond_to do |format|
      if @objeto.update(observacion_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Observacion was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /observaciones/1
  # DELETE /observaciones/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Observacion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_observacion
      @objeto = Observacion.find(params[:id])
    end

    def set_redireccion
      @redireccion = @objeto.linea.present? ? @objeto.linea : @objeto.tabla
    end

    # Only allow a list of trusted parameters through.
    def observacion_params
      params.require(:observacion).permit(:orden, :observacion, :columna_id, :linea_id, :tabla_id, :detalle)
    end
end
