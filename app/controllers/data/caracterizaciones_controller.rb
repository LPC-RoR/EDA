class Data::CaracterizacionesController < ApplicationController
  before_action :carga_temas_ayuda
  before_action :set_caracterizacion, only: [:show, :edit, :update, :destroy, :crear_tabla, :eliminar_tabla]

  # GET /caracterizaciones
  # GET /caracterizaciones.json
  def index
    @coleccion = Caracterizacion.all
  end

  # GET /caracterizaciones/1
  # GET /caracterizaciones/1.json
  def show

    if params[:html_options].blank?
      @tab = 'Características'
    else
      @tab = (params[:html_options][:tab].blank? ? 'Características' : params[:html_options][:tab])
    end
    @options = {'tab' => @tab}

    @coleccion = {}
    if @tab == 'Características'
      @coleccion['caracteristicas'] = @objeto.caracteristicas.order(:orden)
    elsif @tab == 'Tablas'
      @coleccion['observaciones'] = @objeto.tabla.observaciones.order(created_at: :desc)
      @coleccion['documentos'] = @objeto.tabla.documentos.order(:documento)
    elsif @tab == 'Gráficos'
    end
  end

  # GET /caracterizaciones/new
  def new
    padre = params[:class_name].constantize.find(params[:objeto_id])
    @objeto = padre.caracterizaciones.new
  end

  # GET /caracterizaciones/1/edit
  def edit
  end

  # POST /caracterizaciones
  # POST /caracterizaciones.json
  def create
    @objeto = Caracterizacion.new(caracterizacion_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Caracterizacion was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /caracterizaciones/1
  # PATCH/PUT /caracterizaciones/1.json
  def update
    respond_to do |format|
      if @objeto.update(caracterizacion_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Caracterizacion was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  def crear_tabla
    # crea Tabla
    tabla = Tabla.create(padre_id: @objeto.id, padre_class: @objeto.class.name)
    # crea Encabezados
    @objeto.caracteristicas.order(:orden).each do |caracteristica|
      tabla.encabezados.create(orden: caracteristica.orden, encabezado: caracteristica.nombre_columna, tipo: caracteristica.tipo)
    end

    redirect_to publicaciones_path
  end

  def eliminar_tabla
    if @objeto.tabla.lineas.empty?
      @objeto.tabla.encabezados.delete_all
      @objeto.tabla.delete
    end

    redirect_to publicaciones_path
  end

  # DELETE /caracterizaciones/1
  # DELETE /caracterizaciones/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Caracterizacion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_caracterizacion
      @objeto = Caracterizacion.find(params[:id])
    end

    def set_redireccion
      @redireccion = publicaciones_path
    end

    # Only allow a list of trusted parameters through.
    def caracterizacion_params
      params.require(:caracterizacion).permit(:caracterizacion, :proyecto_id)
    end
end
