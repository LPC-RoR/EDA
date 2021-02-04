class MetodologiasController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :set_metodologia, only: [:show, :edit, :update, :destroy]

  # GET /metodologias
  # GET /metodologias.json
  def index
    @coleccion = Metodologia.all
  end

  # GET /metodologias/1
  # GET /metodologias/1.json
  def show
  end

  # GET /metodologias/new
  def new
    @objeto = Metodologia.new
  end

  def nuevo
    @nueva_metodologia = params[:nueva_metodologia][:metodologia].strip
    @publicacion   = Publicacion.find(params[:publicacion_id])
    @maximo = @publicacion.metodologias.empty? ? 0 : @publicacion.metodologias.all.map {|m| m.orden}.max

    @publicacion.metodologias.create(metodologia: @nueva_metodologia, orden: @maximo + 1)

    redirect_to @publicacion
  end

  # GET /metodologias/1/edit
  def edit
  end

  # POST /metodologias
  # POST /metodologias.json
  def create
    @objeto = Metodologia.new(metodologia_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Metodologia was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /metodologias/1
  # PATCH/PUT /metodologias/1.json
  def update
    respond_to do |format|
      if @objeto.update(metodologia_params)
        format.html { redirect_to @objeto, notice: 'Metodologia was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /metodologias/1
  # DELETE /metodologias/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to metodologias_url, notice: 'Metodologia was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_metodologia
      @objeto = Metodologia.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def metodologia_params
      params.require(:metodologia).permit(:metodologia, :orden, :publicacion_id)
    end
end
