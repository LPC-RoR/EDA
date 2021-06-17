class Carpeta < ApplicationRecord
	# MARCA CARPETAS QUE NO SE MODIFICAN NI ELIMINAN
	NOT_MODIFY = ['Carga', 'Ingreso', 'Duplicadas', 'Postergadas', 'Excluidas', 'Aceptadas']

	TABLA_FIELDS = [
		['carpeta', 'show'], 
	]

 	FORM_FIELDS = [
		['carpeta',      'entry'],
		['proyecto_id', 'hidden'],
		['perfil_id',   'hidden']
	]

	belongs_to :proyecto

	has_many :clasificaciones
	has_many :publicaciones, through: :clasificaciones

	has_many :herencias
	has_many :temas, through: :herencias

	has_many :alcances
	has_many :reportes, through: :alcances

end
