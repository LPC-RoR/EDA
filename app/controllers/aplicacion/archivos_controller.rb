class Aplicacion::ArchivosController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_archivo, only: [:show, :edit, :update, :destroy]

  # GET /archivos
  # GET /archivos.json
  def index
    @coleccion = Archivo.all
  end

  # GET /archivos/1
  # GET /archivos/1.json
  def show
  end

  # GET /archivos/new
  def new
    padre = params[:class_name].constantize.find(params[:objeto_id])
    @objeto = padre.archivos.new
  end

  # GET /archivos/1/edit
  def edit
  end

  # POST /archivos
  # POST /archivos.json
  def create
    @objeto = Archivo.new(archivo_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Archivo was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /archivos/1
  # PATCH/PUT /archivos/1.json
  def update
    respond_to do |format|
      if @objeto.update(archivo_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Archivo was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /archivos/1
  # DELETE /archivos/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Archivo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_archivo
      @objeto = Archivo.find(params[:id])
    end

    def set_redireccion
      if @objeto.directorio.present?
        @redireccion = @objeto.directorio
      elsif @objeto.linea.present?
        @redireccion = @objeto.linea
      elsif @objeto.documento.present?
        @redireccion = @objeto.documento
      end
    end

    # Only allow a list of trusted parameters through.
    def archivo_params
      params.require(:archivo).permit(:orden, :archivo, :nota, :linea_id, :directorio_id, :documento_id)
    end
end
