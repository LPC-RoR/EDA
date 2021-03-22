class RecursosController < ApplicationController
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
#  before_action :set_recurso, only: [:show, :edit, :update, :destroy]

  def home
    @coleccion = {}
    @coleccion['tema_ayudas'] = TemaAyuda.where(tipo: 'inicio').order(:orden)
  end

  def bibliografia
  	proyecto_activo = Proyecto.find(session[:proyecto_activo]['id'])

  	ids_publicaciones = []
  	proyecto_activo.carpetas_personalizadas.each do |carpeta|
  		unless carpeta.publicaciones.empty?
  			ids_publicaciones = ids_publicaciones.union(carpeta.publicaciones.ids)
  		end
  	end
  	@coleccion = {}
  	@coleccion['publicaciones'] = Publicacion.where(id: ids_publicaciones.uniq).order(:author)
  end

  def borrar_archivos
  	Autor.delete_all
  	Carga.delete_all
  	Carpeta.delete_all
  	Cita.delete_all
  	Clasificacion.delete_all
  	Departamento.delete_all
  	Evaluacion.delete_all
  	Idioma.delete_all
  	Institucion.delete_all
  	Investigador.delete_all
  	Proceso.delete_all
  	Publicacion.delete_all
  	Registro.delete_all
  	Revista.delete_all
  	Texto.delete_all
  	Tema.delete_all

  	redirect_to root
  end

  private
    # Use callbacks to share common setup or constraints between actions.
end
 