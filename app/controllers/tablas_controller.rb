class TablasController < ApplicationController
  before_action :set_tabla, only: [:show, :edit, :update, :destroy]

  # GET /tablas
  # GET /tablas.json
  def index
    @coleccion = Tabla.all
  end

  # GET /tablas/1
  # GET /tablas/1.json
  def show
    if params[:html_options].blank?
      @tab = 'lineas'
    else
      @tab = params[:html_options][:tab].blank? ? 'lineas' : params[:html_options][:tab]
    end
    @options = { 'tab' => @tab }

    @coleccion = {}
    @coleccion['lineas'] = @objeto.lineas.order(:orden)
    @coleccion['especificaciones'] = @objeto.especificaciones
    @coleccion['observaciones'] = @objeto.observaciones
  end

  # GET /tablas/new
  def new
    @objeto = Tabla.new(padre_id: params[:etapa_id])
  end

  # GET /tablas/1/edit
  def edit
  end

  # POST /tablas
  # POST /tablas.json
  def create
    @objeto = Tabla.new(tabla_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Tabla was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tablas/1
  # PATCH/PUT /tablas/1.json
  def update
    respond_to do |format|
      if @objeto.update(tabla_params)
        format.html { redirect_to @objeto, notice: 'Tabla was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tablas/1
  # DELETE /tablas/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to tablas_url, notice: 'Tabla was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tabla
      @objeto = Tabla.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tabla_params
      params.require(:tabla).permit(:tabla, :padre_id, :archivo, :orden)
    end
end
