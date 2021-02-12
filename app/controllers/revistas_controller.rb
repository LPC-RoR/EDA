class RevistasController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_revista, only: [:show, :edit, :update, :destroy]

  # GET /revistas
  # GET /revistas.json
  def index
    @coleccion = Revista.all
  end

  # GET /revistas/1
  # GET /revistas/1.json
  def show
    @tab = params[:tab].blank? ? 'publicaciones' : params[:tab]
#    @estado = params[:estado].blank? ? @tab.classify.constantize::ESTADOS[0] : params[:estado]
    # tenemos que cubrir todos los casos
    # 1. has_many : }
    @coleccion = {}
    @coleccion[@tab] = @objeto.send(@tab).page(params[:page]) #.where(estado: @estado)
  end

  # GET /revistas/new
  def new
    @objeto = Revista.new
  end

  # GET /revistas/1/edit
  def edit
  end

  # POST /revistas
  # POST /revistas.json
  def create
    @objeto = Revista.new(revista_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Revista was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /revistas/1
  # PATCH/PUT /revistas/1.json
  def update
    respond_to do |format|
      if @objeto.update(revista_params)
        format.html { redirect_to @objeto, notice: 'Revista was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /revistas/1
  # DELETE /revistas/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to revistas_url, notice: 'Revista was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_revista
      @objeto = Revista.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def revista_params
      params.require(:revista).permit(:revista, :idioma_id)
    end
end
