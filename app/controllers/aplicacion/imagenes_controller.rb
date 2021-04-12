class Aplicacion::ImagenesController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_imagen, only: [:show, :edit, :update, :destroy]

  # GET /imagenes
  # GET /imagenes.json
  def index
    @coleccion = Imagen.all
  end

  # GET /imagenes/1
  # GET /imagenes/1.json
  def show
  end

  # GET /imagenes/new
  def new
    padre = params[:class_name].constantize.find(params[:objeto_id])
    @objeto = padre.imagenes.new
  end

  # GET /imagenes/1/edit
  def edit
  end

  # POST /imagenes
  # POST /imagenes.json
  def create
    @objeto = Imagen.new(imagen_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Imagen was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /imagenes/1
  # PATCH/PUT /imagenes/1.json
  def update
    respond_to do |format|
      if @objeto.update(imagen_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Imagen was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /imagenes/1
  # DELETE /imagenes/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Imagen was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_imagen
      @objeto = Imagen.find(params[:id])
    end

    def set_redireccion
      if @objeto.directorio.present?
        @redireccion = @objeto.directorio
      elsif @objeto.linea.present?
        @redireccion = @objeto.linea
      end
    end

    # Only allow a list of trusted parameters through.
    def imagen_params
      params.require(:imagen).permit(:orden, :imagen, :nota, :linea_id, :directorio_id)
    end
end
