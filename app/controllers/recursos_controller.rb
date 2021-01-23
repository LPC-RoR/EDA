class RecursosController < ApplicationController
#  before_action :set_recurso, only: [:show, :edit, :update, :destroy]

  # GET /recursos/tablas
  def tablas
    @ftab = params[:ftab].blank? ? Configuracion::RECURSO_ACTIONS_TABS[action_name][0] : params[:ftab]
    @estado = params[:estado].blank? ? @ftab.classify.constantize::ESTADOS[0] : params[:estado]
    # Manejo de Tablas, Tabs y Estados
#    @coleccion = @ftab.classify.constantize::all.where(estado: @estado)
    @coleccion = @ftab.classify.constantize::all
  end

  def manual
    @ftab = 'publicaciones'
#    @ftab = params[:ftab].blank? ? Configuracion::RECURSO_ACTIONS_TABS[action_name][0] : params[:ftab]
#    @estado = params[:estado].blank? ? @ftab.classify.constantize::ESTADOS[0] : params[:estado]
    @coleccion = Publicacion.where(origen: 'Manual').page(params[:page])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
end
 