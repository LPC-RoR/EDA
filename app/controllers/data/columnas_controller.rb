class Data::ColumnasController < ApplicationController
  before_action :carga_temas_ayuda
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
    publicacion = Publicacion.find(params[:o])
    @caracteristica = Caracteristica.find(params[:c])
     if publicacion.linea(@caracteristica.caracterizacion).blank?
      Linea.create(tabla_id: @caracteristica.caracterizacion.tabla.id, referencia_id: publicacion.id, referencia_class: 'Publicacion')
     end
     # Aquí ya la línea está creada
    @objeto = publicacion.linea(@caracteristica.caracterizacion).columnas.new(orden: @caracteristica.orden)
  end

  # GET /columnas/1/edit
  def edit
    @caracteristica = Caracteristica.find_by(orden: @objeto.orden)
  end

  # POST /columnas
  # POST /columnas.json
  def create
    @objeto = Columna.new(columna_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Columna was successfully created.' }
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
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Columna was successfully updated.' }
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
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Columna was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_columna
      @objeto = Columna.find(params[:id])
    end

    def set_redireccion
      @redireccion = (@objeto.linea.referencia.present? ? @objeto.linea.referencia : @objeto.linea.tabla)
    end

    # Only allow a list of trusted parameters through.
    def columna_params
      params.require(:columna).permit(:orden, :linea_id, :columna)
    end
end
