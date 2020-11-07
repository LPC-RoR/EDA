class RepositoriosController < ApplicationController
  before_action :set_repositorio, only: [:show, :edit, :update, :destroy]

  # GET /repositorios
  # GET /repositorios.json
  def index
    @repositorios = Repositorio.all
  end

  # GET /repositorios/1
  # GET /repositorios/1.json
  def show
  end

  # GET /repositorios/new
  def new
    @repositorio = Repositorio.new
  end

  # GET /repositorios/1/edit
  def edit
  end

  # POST /repositorios
  # POST /repositorios.json
  def create
    @repositorio = Repositorio.new(repositorio_params)

    respond_to do |format|
      if @repositorio.save
        format.html { redirect_to @repositorio, notice: 'Repositorio was successfully created.' }
        format.json { render :show, status: :created, location: @repositorio }
      else
        format.html { render :new }
        format.json { render json: @repositorio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /repositorios/1
  # PATCH/PUT /repositorios/1.json
  def update
    respond_to do |format|
      if @repositorio.update(repositorio_params)
        format.html { redirect_to @repositorio, notice: 'Repositorio was successfully updated.' }
        format.json { render :show, status: :ok, location: @repositorio }
      else
        format.html { render :edit }
        format.json { render json: @repositorio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repositorios/1
  # DELETE /repositorios/1.json
  def destroy
    @repositorio.destroy
    respond_to do |format|
      format.html { redirect_to repositorios_url, notice: 'Repositorio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repositorio
      @repositorio = Repositorio.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def repositorio_params
      params.require(:repositorio).permit(:repositorio)
    end
end
