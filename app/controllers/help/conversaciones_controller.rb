class Help::ConversacionesController < ApplicationController
  before_action :set_conversacion, only: %i[ show edit update destroy ]

  # GET /conversaciones or /conversaciones.json
  def index
    @coleccion = Conversacion.all
  end

  # GET /conversaciones/1 or /conversaciones/1.json
  def show
  end

  # GET /conversaciones/new
  def new
    @objeto = Conversacion.new
  end

  # GET /conversaciones/1/edit
  def edit
  end

  # POST /conversaciones or /conversaciones.json
  def create
    @objeto = Conversacion.new(conversacion_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: "Conversacion was successfully created." }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conversaciones/1 or /conversaciones/1.json
  def update
    respond_to do |format|
      if @objeto.update(conversacion_params)
        format.html { redirect_to @objeto, notice: "Conversacion was successfully updated." }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversaciones/1 or /conversaciones/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to conversaciones_url, notice: "Conversacion was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversacion
      @objeto = Conversacion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def conversacion_params
      params.require(:conversacion).permit(:parent_id, :child_id)
    end
end
