class EtapasController < ApplicationController
  before_action :set_etapa, only: [:show, :edit, :update, :destroy]

  # GET /etapas
  # GET /etapas.json
  def index
    @coleccion = Etapa.all
  end

  # GET /etapas/1
  # GET /etapas/1.json
  def show
    if params[:html_options].blank?
      @tab = 'tablas'
    else
      @tab = params[:html_options][:tab].blank? ? 'tablas' : params[:html_options][:tab]
    end
    @options = { 'tab' => @tab }

    @coleccion = {}
    @coleccion['tablas'] = @objeto.tablas
    @coleccion['especificaciones'] = @objeto.especificaciones

  end
  # GET /etapas/new
  def new
    @objeto = Etapa.new(proyecto_id: params[:proyecto_id])
  end

  # GET /etapas/1/edit
  def edit
  end

  # POST /etapas
  # POST /etapas.json
  def create
    @objeto = Etapa.new(etapa_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Etapa was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /etapas/1
  # PATCH/PUT /etapas/1.json
  def update
    respond_to do |format|
      if @objeto.update(etapa_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Etapa was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /etapas/1
  # DELETE /etapas/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Etapa was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_etapa
      @objeto = Etapa.find(params[:id])
    end

    def set_redireccion
      @redireccion = proyecto_path(@objeto.proyecto, html_options: {tab: 'etapas'})
    end

    # Only allow a list of trusted parameters through.
    def etapa_params
      params.require(:etapa).permit(:orden, :etapa, :proyecto_id)
    end
end
