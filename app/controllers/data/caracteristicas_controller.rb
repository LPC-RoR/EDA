class Data::CaracteristicasController < ApplicationController
  before_action :carga_temas_ayuda
  before_action :set_caracteristica, only: [:show, :edit, :update, :destroy]

  # GET /caracteristicas
  # GET /caracteristicas.json
  def index
    @coleccion = Caracteristica.all
  end

  # GET /caracteristicas/1
  # GET /caracteristicas/1.json
  def show
  end

  # GET /caracteristicas/new
  def new
    padre = Caracterizacion.find(params[:caracterizacion_id])
    @objeto = padre.caracteristicas.new
  end

  # GET /caracteristicas/1/edit
  def edit
  end

  # POST /caracteristicas
  # POST /caracteristicas.json
  def create
    @objeto = Caracteristica.new(caracteristica_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Caracteristica was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /caracteristicas/1
  # PATCH/PUT /caracteristicas/1.json
  def update
    respond_to do |format|
      if @objeto.update(caracteristica_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Caracteristica was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /caracteristicas/1
  # DELETE /caracteristicas/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Caracteristica was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_caracteristica
      @objeto = Caracteristica.find(params[:id])
    end

    def set_redireccion
      @redireccion = @objeto.caracterizacion
    end

    # Only allow a list of trusted parameters through.
    def caracteristica_params
      params.require(:caracteristica).permit(:caracteristica, :nombre_columna, :orden, :tipo, :caracterizacion_id)
    end
end
