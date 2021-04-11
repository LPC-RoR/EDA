class EtqContadoresController < ApplicationController
  before_action :set_etq_contador, only: [:show, :edit, :update, :destroy]

  # GET /etq_contadores
  # GET /etq_contadores.json
  def index
    @coleccion = EtqContador.all
  end

  # GET /etq_contadores/1
  # GET /etq_contadores/1.json
  def show
  end

  # GET /etq_contadores/new
  def new
    @objeto = EtqContador.new
  end

  # GET /etq_contadores/1/edit
  def edit
  end

  # POST /etq_contadores
  # POST /etq_contadores.json
  def create
    @objeto = EtqContador.new(etq_contador_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Etq contador was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /etq_contadores/1
  # PATCH/PUT /etq_contadores/1.json
  def update
    respond_to do |format|
      if @objeto.update(etq_contador_params)
        format.html { redirect_to @objeto, notice: 'Etq contador was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /etq_contadores/1
  # DELETE /etq_contadores/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to etq_contadores_url, notice: 'Etq contador was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_etq_contador
      @objeto = EtqContador.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def etq_contador_params
      params.require(:etq_contador).permit(:etiqueta_id, :publicacion_id)
    end
end
