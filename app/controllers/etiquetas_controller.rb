class EtiquetasController < ApplicationController
  before_action :inicia_sesion
  before_action :authenticate_usuario!
  before_action :carga_temas_ayuda
  before_action :set_etiqueta, only: [:show, :edit, :update, :destroy, :asignar, :desasignar]

  # GET /etiquetas
  # GET /etiquetas.json
  def index
    @coleccion = Etiqueta.all
  end

  # GET /etiquetas/1
  # GET /etiquetas/1.json
  def show
    @coleccion = {}
    @coleccion['publicaciones'] = @objeto.publicaciones.page(params[:page])
  end

  # GET /etiquetas/new
  def new
    @objeto = Etiqueta.new
  end

  def nuevo
    publicacion = Publicacion.find(params[:objeto_id])
    unless params[:nueva_etiqueta][:etiqueta].blank?
      proyecto_activo = Proyecto.find(session[:proyecto_activo]['id'])

      nombres_etiquetas = proyecto_activo.etiquetas.map {|etq| etq.etiqueta.downcase}
      unless nombres_etiquetas.include?(params[:nueva_etiqueta][:etiqueta].strip.downcase)
        proyecto_activo.etiquetas.create(etiqueta: params[:nueva_etiqueta][:etiqueta].strip.downcase)
      end
    end
    redirect_to publicacion
  end

  # GET /etiquetas/1/edit
  def edit
  end

  # POST /etiquetas
  # POST /etiquetas.json
  def create
    @objeto = Etiqueta.new(etiqueta_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Etiqueta was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /etiquetas/1
  # PATCH/PUT /etiquetas/1.json
  def update
    respond_to do |format|
      if @objeto.update(etiqueta_params)
        format.html { redirect_to @objeto, notice: 'Etiqueta was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  def asignar
    publicacion = Publicacion.find(params[:objeto_id])
    publicacion.etiquetas << @objeto

    redirect_to publicacion
  end

  def desasignar
    publicacion = Publicacion.find(params[:objeto_id])
    publicacion.etiquetas.delete(@objeto)

    redirect_to publicacion
  end

  # DELETE /etiquetas/1
  # DELETE /etiquetas/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to etiquetas_url, notice: 'Etiqueta was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_etiqueta
      @objeto = Etiqueta.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def etiqueta_params
      params.require(:etiqueta).permit(:etiqueta, :proyecto_id)
    end
end
