class Carpeta < ApplicationRecord
	# MARCA CARPETAS QUE NO SE MODIFICAN NI ELIMINAN
	NOT_MODIFY = ['Revisar', 'Excluidas', 'Postergadas', 'Revisadas']

	#-------------------------------------------------------------  TABLA
	TABLA_FIELDS = [
		['carpeta', 'show'], 
	]

 	FORM_FIELDS = [
		['carpeta',              'entry'],
		['investigador_id',     'hidden']
	]

	# ------------------------------------------------------------- DESPLIEGUE
	HIDDEN_CHILDS = ['clasificaciones']
	SHOW_HMT_COLLECTIONS = ['publicaciones']

	belongs_to :investigador

	has_many :clasificaciones
	has_many :publicaciones, through: :clasificaciones

end
