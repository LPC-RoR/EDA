class Data::ColumnasController < ApplicationController
  before_action :set_columna, only: [:show, :edit, :update, :destroy]

  # GET /columnas
  # GET /columnas.json
  def index
    @coleccion = Columna.all
  end

  # GET /columnas/1
  # GET /columnas/1.json
  def show
  end

  # GET /columnas/new
  def new
    @objeto = Columna.new
  end

  # GET /columnas/1/edit
  def edit
  end

  # POST /columnas
  # POST /columnas.json
  def create
    @objeto = Columna.new(columna_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Columna was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /columnas/1
  # PATCH/PUT /columnas/1.json
  def update
    respond_to do |format|
      if @objeto.update(columna_params)
        format.html { redirect_to @objeto, notice: 'Columna was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /columnas/1
  # DELETE /columnas/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to columnas_url, notice: 'Columna was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_columna
      @objeto = Columna.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def columna_params
      params.require(:columna).permit(:orden, :linea_id)
    end
end
