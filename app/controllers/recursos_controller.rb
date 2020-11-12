class RecursosController < ApplicationController
  before_action :set_recurso, only: [:show, :edit, :update, :destroy]

  # GET /recursos
  # GET /recursos.json
  def index
    @coleccion = Recurso.all
  end

  # GET /recursos/1
  # GET /recursos/1.json
  def show
  end

  # GET /recursos/new
  def new
    @objeto = Recurso.new
  end

  # GET /recursos/1/edit
  def edit
  end

  # POST /recursos
  # POST /recursos.json
  def create
    @objeto = Recurso.new(recurso_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Recurso was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recursos/1
  # PATCH/PUT /recursos/1.json
  def update
    respond_to do |format|
      if @objeto.update(recurso_params)
        format.html { redirect_to @objeto, notice: 'Recurso was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recursos/1
  # DELETE /recursos/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to recursos_url, notice: 'Recurso was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recurso
      @objeto = Recurso.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recurso_params
      params.fetch(:recurso, {})
    end
end
