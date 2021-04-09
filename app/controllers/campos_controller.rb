class CamposController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_campo, only: [:show, :edit, :update, :destroy]

  # GET /campos
  # GET /campos.json
  def index
    @coleccion = Campo.all
  end

  # GET /campos/1
  # GET /campos/1.json
  def show
  end

  # GET /campos/new
  def new
    tpi = params[:tipo_publicacion_id].present? ? params[:tipo_publicacion_id] : nil
    @objeto = Campo.new(tipo_publicacion_id: tpi)
  end

  # GET /campos/1/edit
  def edit
  end

  # POST /campos
  # POST /campos.json
  def create
    @objeto = Campo.new(campo_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Campo was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campos/1
  # PATCH/PUT /campos/1.json
  def update
    respond_to do |format|
      if @objeto.update(campo_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Campo was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campos/1
  # DELETE /campos/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Campo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campo
      @objeto = Campo.find(params[:id])
    end

    def set_redireccion
      @redireccion = (@objeto.tipo_publicacion.present? ? @objeto.tipo_publicacion : @objeto.perfil)
    end

    # Only allow a list of trusted parameters through.
    def campo_params
      params.require(:campo).permit(:campo, :orden, :cursiva, :negrita, :tipo_publicacion_id, :formato_id, :dot)
    end
end
