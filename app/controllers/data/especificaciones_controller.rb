class Data::EspecificacionesController < ApplicationController
  before_action :carga_temas_ayuda
  before_action :set_especificacion, only: [:show, :edit, :update, :destroy]

  # GET /especificaciones
  # GET /especificaciones.json
  def index
    @coleccion = Especificacion.all
  end

  # GET /especificaciones/1
  # GET /especificaciones/1.json
  def show
  end

  # GET /especificaciones/new
  def new
    padre = Etapa.find(params[:etapa_id]) unless params[:etapa_id].blank?
    padre = Tabla.find(params[:tabla_id]) unless params[:tabla_id].blank?

    @objeto = padre.especificaciones.new
  end

  def nuevo
  end

  # GET /especificaciones/1/edit
  def edit
  end

  # POST /especificaciones
  # POST /especificaciones.json
  def create
    @objeto = Especificacion.new(especificacion_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Especificacion was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /especificaciones/1
  # PATCH/PUT /especificaciones/1.json
  def update
    respond_to do |format|
      if @objeto.update(especificacion_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Especificacion was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /especificaciones/1
  # DELETE /especificaciones/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Especificacion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_especificacion
      @objeto = Especificacion.find(params[:id])
    end

    def set_redireccion
      @redireccion = @objeto.etapa_id.blank? ? @objeto.tabla : datos_path
    end

    # Only allow a list of trusted parameters through.
    def especificacion_params
      params.require(:especificacion).permit(:orden, :especificacion, :detalle, :tabla_id, :etapa_id)
    end
end
