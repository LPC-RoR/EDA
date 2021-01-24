class IngresosController < ApplicationController
  before_action :set_ingreso, only: [:show, :edit, :update, :destroy]

  # GET /ingresos
  # GET /ingresos.json
  def index
    @activo = Perfil.find(session[:perfil_activo]['id'])
    @table_controller = 'publicaciones'
    @coleccion = @activo.ingresos.where(origen: 'ingreso').page(params[:page])
  end

  # GET /ingresos/1
  # GET /ingresos/1.json
  def show
  end

  # GET /ingresos/new
  def new
    @objeto = Ingreso.new
  end

  # GET /ingresos/1/edit
  def edit
  end

  # POST /ingresos
  # POST /ingresos.json
  def create
    @objeto = Ingreso.new(ingreso_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Ingreso was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ingresos/1
  # PATCH/PUT /ingresos/1.json
  def update
    respond_to do |format|
      if @objeto.update(ingreso_params)
        format.html { redirect_to @objeto, notice: 'Ingreso was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingresos/1
  # DELETE /ingresos/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to ingresos_url, notice: 'Ingreso was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingreso
      @objeto = Ingreso.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ingreso_params
      params.fetch(:ingreso, {})
    end
end
