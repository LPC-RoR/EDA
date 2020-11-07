class RevistasController < ApplicationController
  before_action :set_revista, only: [:show, :edit, :update, :destroy]

  # GET /revistas
  # GET /revistas.json
  def index
    @revistas = Revista.all
  end

  # GET /revistas/1
  # GET /revistas/1.json
  def show
  end

  # GET /revistas/new
  def new
    @revista = Revista.new
  end

  # GET /revistas/1/edit
  def edit
  end

  # POST /revistas
  # POST /revistas.json
  def create
    @revista = Revista.new(revista_params)

    respond_to do |format|
      if @revista.save
        format.html { redirect_to @revista, notice: 'Revista was successfully created.' }
        format.json { render :show, status: :created, location: @revista }
      else
        format.html { render :new }
        format.json { render json: @revista.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /revistas/1
  # PATCH/PUT /revistas/1.json
  def update
    respond_to do |format|
      if @revista.update(revista_params)
        format.html { redirect_to @revista, notice: 'Revista was successfully updated.' }
        format.json { render :show, status: :ok, location: @revista }
      else
        format.html { render :edit }
        format.json { render json: @revista.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /revistas/1
  # DELETE /revistas/1.json
  def destroy
    @revista.destroy
    respond_to do |format|
      format.html { redirect_to revistas_url, notice: 'Revista was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_revista
      @revista = Revista.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def revista_params
      params.require(:revista).permit(:revista, :idioma_id)
    end
end
