class FormatosController < ApplicationController
  before_action :set_formato, only: [:show, :edit, :update, :destroy]

  # GET /formatos
  # GET /formatos.json
  def index
    @formatos = Formato.all
  end

  # GET /formatos/1
  # GET /formatos/1.json
  def show
  end

  # GET /formatos/new
  def new
    @formato = Formato.new
  end

  # GET /formatos/1/edit
  def edit
  end

  # POST /formatos
  # POST /formatos.json
  def create
    @formato = Formato.new(formato_params)

    respond_to do |format|
      if @formato.save
        format.html { redirect_to @formato, notice: 'Formato was successfully created.' }
        format.json { render :show, status: :created, location: @formato }
      else
        format.html { render :new }
        format.json { render json: @formato.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /formatos/1
  # PATCH/PUT /formatos/1.json
  def update
    respond_to do |format|
      if @formato.update(formato_params)
        format.html { redirect_to @formato, notice: 'Formato was successfully updated.' }
        format.json { render :show, status: :ok, location: @formato }
      else
        format.html { render :edit }
        format.json { render json: @formato.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /formatos/1
  # DELETE /formatos/1.json
  def destroy
    @formato.destroy
    respond_to do |format|
      format.html { redirect_to formatos_url, notice: 'Formato was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_formato
      @formato = Formato.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def formato_params
      params.require(:formato).permit(:formato, :perfil_id)
    end
end
