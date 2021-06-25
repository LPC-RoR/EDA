class Aplicacion::DocumentosController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_documento, only: [:show, :edit, :update, :destroy]

  # GET /documentos
  # GET /documentos.json
  def index
    proyecto_activo = Proyecto.find(session[:proyecto_activo]['id'])

    @coleccion = {}
    @coleccion['documentos'] = proyecto_activo.documentos.order(:documento)
  end

  # GET /documentos/1
  # GET /documentos/1.json
  def show
    @coleccion = {}
    @coleccion['archivos'] = @objeto.archivos.order(created_at: :desc)
  end

  # GET /documentos/new
  def new
    if params[:etapa_id].present?
      padre = Etapa.find(params[:etapa_id])
    elsif params[:tabla_id].present?
      padre = Tabla.find(params[:tabla_id])
    else
      padre = Proyecto.find(session[:proyecto_activo]['id'])
    end
    @objeto = padre.documentos.new
  end

  # GET /documentos/1/edit
  def edit
  end

  # POST /documentos
  # POST /documentos.json
  def create
    @objeto = Documento.new(documento_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Documento was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documentos/1
  # PATCH/PUT /documentos/1.json
  def update
    respond_to do |format|
      if @objeto.update(documento_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Documento was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documentos/1
  # DELETE /documentos/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Documento was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_documento
      @objeto = Documento.find(params[:id])
    end

    def set_redireccion
      if @objeto.proyecto.present?
        @redireccion = documentos_path
      elsif @objeto.tabla.present?
        @redireccion = @objeto.tabla
      elsif @objeto.etapa.present?
        @redireccion = datos_path
      end
    end

    # Only allow a list of trusted parameters through.
    def documento_params
      params.require(:documento).permit(:documento, :proyecto_id, :etapa_id, :tabla_id)
    end
end
