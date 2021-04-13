class TextosController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_texto, only: [:show, :edit, :update, :destroy, :desasignar]

  # GET /textos
  # GET /textos.json
  def index
    @coleccion = {}
    @coleccion[controller_name] = Texto.all
  end

  # GET /textos/1
  # GET /textos/1.json
  def show
    @coleccion = {}
    @coleccion['publicaciones'] = @objeto.publicaciones.page(params[:page])
    @coleccion['temas'] = @objeto.temas.order(:temas)
  end

  # GET /textos/new
  def new
    @carpeta = Carpeta.find(params[:carpeta_id])
    @publicacion = Publicacion.find(params[:publicacion_id])
    @objeto = Texto.new
    @carpeta.textos << @objeto
    @publicacion.textos << @objeto
  end

  def nuevo
    # se pone fuera para saber donde redireccionar
    @publicacion  = Publicacion.find(params[:publicacion_id])

    unless params[:texto_base][:texto].strip.blank? or params[:texto_base][:tema_id].blank? or params[:texto_base][:clasificacion].blank?
      texto_limpio = params[:texto_base][:texto].strip.downcase
      sha1         = Digest::SHA1.hexdigest(texto_limpio)
      tema         = Tema.find(params[:texto_base][:tema_id])

      texto = Texto.find_by(sha1: sha1)
      if texto.blank?
        texto = Texto.create(texto: texto_limpio, sha1: sha1)
      end
      # los téxtos son únicos, por lo que NO tiene sentido permitir duplicados
      unless tema.textos.ids.include?(texto.id)
        tema.textos << texto
      end
      # Si YA EXISTÍA la relación, actualiza la clasificación, privilegia el útlimo criterio
      clasificacion = tema.clasificaciones.find_by(texto_id: texto.id)
      clasificacion.clasificacion = params[:texto_base][:clasificacion]
      clasificacion.save

      # Evita duplicados
      unless texto.publicaciones.ids.include?(@publicacion.id)
        @publicacion.textos << texto
      end
    end

    redirect_to @publicacion
  end

  def agregar_tema
    @tema = Tema.find(params[:a_params][:a_tema_id])
    @texto = Texto.find(params[:texto_id])

    @tema.textos << @texto
    redirect_to @texto
  end
  def eliminar_tema
    @texto = Texto.find(params[:texto_id])
    @clasificacion = Clasificacion.find_by(tema_id: params[:e_params][:e_tema_id], texto_id: params[:texto_id])

    @clasificacion.delete
    redirect_to @texto
  end

  # GET /textos/1/edit
  def edit
  end

  # POST /textos
  # POST /textos.json
  def create
    @objeto = Texto.new(texto_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Texto was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /textos/1
  # PATCH/PUT /textos/1.json
  def update
    respond_to do |format|
      if @objeto.update(texto_params)
        format.html { redirect_to @objeto, notice: 'Texto was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /textos/1
  # DELETE /textos/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to textos_url, notice: 'Texto was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def desasignar
    publicacion = Publicacion.find(params[:objeto_id])
    publicacion.textos.delete(@objeto)

    if @objeto.publicaciones.count == 0
      @objeto.temas.delete_all
      @objeto.delete 
    end

    redirect_to publicacion
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_texto
      @objeto = Texto.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def texto_params
      params.require(:texto).permit(:texto, :calificacion, :publicacion_id)
    end
end
