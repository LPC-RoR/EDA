class AgregacionesController < ApplicationController
  before_action :set_agregacioneses, only: [:show, :edit, :update, :destroy]

  # GET /agregaciones
  # GET /agregaciones.json
  def index
    @agregaciones = Agregacion.all
  end

  # GET /agregaciones/1
  # GET /agregaciones/1.json
  def show
  end

  # GET /agregaciones/new
  def new
    @agregacioneses = Agregacion.new
  end

  # GET /agregaciones/1/edit
  def edit
  end

  # POST /agregaciones
  # POST /agregaciones.json
  def create
    @agregacioneses = Agregacion.new(agregacioneses_params)

    respond_to do |format|
      if @agregacioneses.save
        format.html { redirect_to @agregacioneses, notice: 'Agregacion was successfully created.' }
        format.json { render :show, status: :created, location: @agregacioneses }
      else
        format.html { render :new }
        format.json { render json: @agregacioneses.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agregaciones/1
  # PATCH/PUT /agregaciones/1.json
  def update
    respond_to do |format|
      if @agregacioneses.update(agregacioneses_params)
        format.html { redirect_to @agregacioneses, notice: 'Agregacion was successfully updated.' }
        format.json { render :show, status: :ok, location: @agregacioneses }
      else
        format.html { render :edit }
        format.json { render json: @agregacioneses.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agregaciones/1
  # DELETE /agregaciones/1.json
  def destroy
    @agregacioneses.destroy
    respond_to do |format|
      format.html { redirect_to agregaciones_url, notice: 'Agregacion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agregacioneses
      @agregacioneses = Agregacion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def agregacioneses_params
      params.require(:agregacioneses).permit(:categoria_id, :concepto_id)
    end
end
