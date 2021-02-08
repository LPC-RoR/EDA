class ValoresController < ApplicationController
  before_action :set_valor, only: [:show, :edit, :update, :destroy]

  # GET /valores
  # GET /valores.json
  def index
    @coleccion = Valor.all
  end

  # GET /valores/1
  # GET /valores/1.json
  def show
  end

  # GET /valores/new
  def new
    @objeto = Valor.new
  end

  # GET /valores/1/edit
  def edit
  end

  # POST /valores
  # POST /valores.json
  def create
    @objeto = Valor.new(valor_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Valor was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /valores/1
  # PATCH/PUT /valores/1.json
  def update
    respond_to do |format|
      if @objeto.update(valor_params)
        format.html { redirect_to @objeto, notice: 'Valor was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /valores/1
  # DELETE /valores/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to valores_url, notice: 'Valor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_valor
      @objeto = Valor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def valor_params
      params.require(:valor).permit(:tipo, :valor)
    end
end
