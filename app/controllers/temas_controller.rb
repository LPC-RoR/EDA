class TemasController < ApplicationController
  before_action :authenticate_usuario!
  before_action :set_tema, only: [:show, :edit, :update, :destroy]

  # GET /temas
  # GET /temas.json
  def index
    @activo = Perfil.find(session[:perfil_activo]['id'])
    @coleccion = @activo.temas
  end

  # GET /temas/1
  # GET /temas/1.json
  def show
    @tab = params[:tab].blank? ? 'textos' : params[:tab]
#    @estado = params[:estado].blank? ? @tab.classify.constantize::ESTADOS[0] : params[:estado]
    # tenemos que cubrir todos los casos
    # 1. has_many : }
    @coleccion = @objeto.send(@tab).page(params[:page]) #.where(estado: @estado)
  end

  # GET /temas/new
  def new
    @objeto = Tema.new(perfil_id: session[:perfil_activo]['id'])
  end

  def nuevo
    @publicacion   = Publicacion.find(params[:publicacion_id])

    unless params[:nuevo_tema][:tema].strip.blank?
      @nuevo_tema = params[:nuevo_tema][:tema].strip
  
      @activo = Perfil.find(session[:perfil_activo]['id'])
      t = @activo.temas.find_by(tema: @nuevo_tema)
      if t.blank?
        @activo.temas.create(tema: @nuevo_tema)
      end
    end

    redirect_to @publicacion
  end

  # GET /temas/1/edit
  def edit
  end

  # POST /temas
  # POST /temas.json
  def create
    @objeto = Tema.new(tema_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Tema was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /temas/1
  # PATCH/PUT /temas/1.json
  def update
    respond_to do |format|
      if @objeto.update(tema_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Tema was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /temas/1
  # DELETE /temas/1.json
  def destroy
    @objeto.destroy
    set_redireccion
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Tema was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tema
      @objeto = Tema.find(params[:id])
    end

    def set_redireccion
      @redireccion = '/temas'
    end

    # Only allow a list of trusted parameters through.
    def tema_params
      params.require(:tema).permit(:tema, :perfil_id)
    end
end
