class PasosController < ApplicationController
  before_action :set_paso, only: [:show, :edit, :update, :destroy]

  # GET /pasos
  # GET /pasos.json
  def index
    @pasos = Paso.all
  end

  # GET /pasos/1
  # GET /pasos/1.json
  def show
  end

  # GET /pasos/new
  def new
    @paso = Paso.new
  end

  # GET /pasos/1/edit
  def edit
  end

  # POST /pasos
  # POST /pasos.json
  def create
    @paso = Paso.new(paso_params)

    respond_to do |format|
      if @paso.save
        format.html { redirect_to @paso, notice: 'Paso was successfully created.' }
        format.json { render :show, status: :created, location: @paso }
      else
        format.html { render :new }
        format.json { render json: @paso.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pasos/1
  # PATCH/PUT /pasos/1.json
  def update
    respond_to do |format|
      if @paso.update(paso_params)
        format.html { redirect_to @paso, notice: 'Paso was successfully updated.' }
        format.json { render :show, status: :ok, location: @paso }
      else
        format.html { render :edit }
        format.json { render json: @paso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pasos/1
  # DELETE /pasos/1.json
  def destroy
    @paso.destroy
    respond_to do |format|
      format.html { redirect_to pasos_url, notice: 'Paso was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paso
      @paso = Paso.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def paso_params
      params.require(:paso).permit(:orden, :paso, :detalle, :tutorial_id)
    end
end
