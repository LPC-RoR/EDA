class VersionesController < ApplicationController
  before_action :set_version, only: [:show, :edit, :update, :destroy]

  # GET /versiones
  # GET /versiones.json
  def index
    @coleccion = Version.all
  end

  # GET /versiones/1
  # GET /versiones/1.json
  def show
  end

  # GET /versiones/new
  def new
    @objeto = Version.new(estado: 'ingreso', proyecto_id: params[:proyecto_id])
  end

  # GET /versiones/1/edit
  def edit
  end

  # POST /versiones
  # POST /versiones.json
  def create
    @objeto = Version.new(version_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Version was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /versiones/1
  # PATCH/PUT /versiones/1.json
  def update
    respond_to do |format|
      if @objeto.update(version_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Version was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /versiones/1
  # DELETE /versiones/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Version was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_version
      @objeto = Version.find(params[:id])
    end

    def set_redireccion
      @redireccion = proyecto_path(@objeto.proyecto, html_options: {tab: 'versiones'})
    end

    # Only allow a list of trusted parameters through.
    def version_params
      params.require(:version).permit(:version, :estado, :nota, :proyecto_id)
    end
end
