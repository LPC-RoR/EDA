class TutorialesController < ApplicationController
  before_action :set_tutorial, only: [:show, :edit, :update, :destroy]

  # GET /tutoriales
  # GET /tutoriales.json
  def index
    @tutoriales = Tutorial.all
  end

  # GET /tutoriales/1
  # GET /tutoriales/1.json
  def show
  end

  # GET /tutoriales/new
  def new
    @tutorial = Tutorial.new
  end

  # GET /tutoriales/1/edit
  def edit
  end

  # POST /tutoriales
  # POST /tutoriales.json
  def create
    @tutorial = Tutorial.new(tutorial_params)

    respond_to do |format|
      if @tutorial.save
        format.html { redirect_to @tutorial, notice: 'Tutorial was successfully created.' }
        format.json { render :show, status: :created, location: @tutorial }
      else
        format.html { render :new }
        format.json { render json: @tutorial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tutoriales/1
  # PATCH/PUT /tutoriales/1.json
  def update
    respond_to do |format|
      if @tutorial.update(tutorial_params)
        format.html { redirect_to @tutorial, notice: 'Tutorial was successfully updated.' }
        format.json { render :show, status: :ok, location: @tutorial }
      else
        format.html { render :edit }
        format.json { render json: @tutorial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tutoriales/1
  # DELETE /tutoriales/1.json
  def destroy
    @tutorial.destroy
    respond_to do |format|
      format.html { redirect_to tutoriales_url, notice: 'Tutorial was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tutorial
      @tutorial = Tutorial.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tutorial_params
      params.require(:tutorial).permit(:orden, :tutorial, :detalle, :tema_ayuda_id)
    end
end
