class Data::DirectoriosController < ApplicationController
  before_action :carga_temas_ayuda
  before_action :set_directorio, only: [:show, :edit, :update, :destroy]

  # GET /directorios
  # GET /directorios.json
  def index
    proyecto_activo = Proyecto.find(session[:proyecto_activo]['id'])

    @coleccion = {}
    @coleccion['directorios'] = proyecto_activo.directorios
  end

  # GET /directorios/1
  # GET /directorios/1.json
  def show
    @padres = Directorio.where(id: @objeto.padres_ids)
    @coleccion = {}
    @coleccion['directorios'] = @objeto.children
    @coleccion['archivos'] = @objeto.archivos
    @coleccion['imagenes'] = @objeto.imagenes 
  end

  # GET /directorios/new
  def new
    proyecto_activo = Proyecto.find(session[:proyecto_activo]['id'])
    @objeto = proyecto_activo.directorios.new
  end

  def nuevo
    padre = Directorio.find(params[:objeto_id])
    directorio = Directorio.create(directorio: params[:nuevo_directorio][:directorio])
    padre.children <<  directorio

    redirect_to padre
  end

  # GET /directorios/1/edit
  def edit
  end

  # POST /directorios
  # POST /directorios.json
  def create
    @objeto = Directorio.new(directorio_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Directorio was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /directorios/1
  # PATCH/PUT /directorios/1.json
  def update
    respond_to do |format|
      if @objeto.update(directorio_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Directorio was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /directorios/1
  # DELETE /directorios/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Directorio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_directorio
      @objeto = Directorio.find(params[:id])
    end

    def set_redireccion
      @redireccion = directorios_path
    end

    # Only allow a list of trusted parameters through.
    def directorio_params
      params.require(:directorio).permit(:directorio, :proyecto_id)
    end
end
