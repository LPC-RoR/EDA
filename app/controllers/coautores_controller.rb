class CoautoresController < ApplicationController
  before_action :set_coautor, only: [:show, :edit, :update, :destroy]

  # GET /coautores
  # GET /coautores.json
  def index
    @coautores = Coautor.all
  end

  # GET /coautores/1
  # GET /coautores/1.json
  def show
  end

  # GET /coautores/new
  def new
    @coautor = Coautor.new
  end

  # GET /coautores/1/edit
  def edit
  end

  # POST /coautores
  # POST /coautores.json
  def create
    @coautor = Coautor.new(coautor_params)

    respond_to do |format|
      if @coautor.save
        format.html { redirect_to @coautor, notice: 'Coautor was successfully created.' }
        format.json { render :show, status: :created, location: @coautor }
      else
        format.html { render :new }
        format.json { render json: @coautor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coautores/1
  # PATCH/PUT /coautores/1.json
  def update
    respond_to do |format|
      if @coautor.update(coautor_params)
        format.html { redirect_to @coautor, notice: 'Coautor was successfully updated.' }
        format.json { render :show, status: :ok, location: @coautor }
      else
        format.html { render :edit }
        format.json { render json: @coautor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coautores/1
  # DELETE /coautores/1.json
  def destroy
    @coautor.destroy
    respond_to do |format|
      format.html { redirect_to coautores_url, notice: 'Coautor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coautor
      @coautor = Coautor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def coautor_params
      params.require(:coautor).permit(:proyecto_id, :perfil_id)
    end
end
