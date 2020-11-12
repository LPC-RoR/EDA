class TextosController < ApplicationController
  before_action :set_texto, only: [:show, :edit, :update, :destroy]

  # GET /textos
  # GET /textos.json
  def index
    @coleccion = Texto.all
  end

  # GET /textos/1
  # GET /textos/1.json
  def show
  end

  # GET /textos/new
  def new
    @objeto = Texto.new
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
