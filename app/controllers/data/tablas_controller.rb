class Data::TablasController < ApplicationController
  before_action :carga_temas_ayuda
  before_action :set_tabla, only: [:show, :edit, :update, :destroy, :cargar_tabla, :descargar_tabla]

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
    @coleccion['documentos'] = @objeto.documentos.order(:documento)
    @coleccion['observaciones'] = @objeto.observaciones.order(created_at: :desc)
  end

  # GET /tablas/new
  def new
    if params[:etapa_id].present?
      p_id = params[:etapa_id]
      p_class = 'Etapa'
    end
    @objeto = Tabla.new(padre_id: p_id, padre_class: p_class)
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
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Tabla was successfully created.' }
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
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Tabla was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  def cargar_tabla
    xlsx = Roo::Spreadsheet.open("#{Rails.root}/public/#{@objeto.archivo.url}")
    linea_proceso = 1
    xlsx.each() do |linea_carga|
      case linea_proceso
      when 1
        linea_carga.each_with_index do |nombre, index_nombre|
          @objeto.encabezados.create(orden: index_nombre+1, encabezado: nombre)
        end
      else
        linea = @objeto.lineas.create(orden: linea_proceso-2)
        linea_carga.each_with_index do |columna, index_columna|
          encabezado = @objeto.encabezados.find_by(orden: index_columna+1)
          linea.columnas.create(orden: index_columna+1, columna: columna)
        end
      end
      linea_proceso += 1
    end
    redirect_to datos_path
  end

  def descargar_tabla
    @objeto.encabezados.delete_all
    @objeto.lineas.each do |linea|
      linea.columnas.delete_all
      linea.delete
    end
    redirect_to datos_path
  end

  # DELETE /tablas/1
  # DELETE /tablas/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Tabla was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tabla
      @objeto = Tabla.find(params[:id])
    end

    def set_redireccion
      @redireccion = datos_path
    end

    # Only allow a list of trusted parameters through.
    def tabla_params
      params.require(:tabla).permit(:tabla, :padre_id, :padre_class, :archivo, :orden, :archivos, :imagenes)
    end
end
