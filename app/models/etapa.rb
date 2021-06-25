class Etapa < ApplicationRecord
	TABLA_FIELDS = [
		['orden',     'normal'],
		['etapa',       'show']
	]

	# -------------------- FORM  -----------------------
 	FORM_FIELDS = [
		['orden',        'entry'],
		['etapa',        'entry'],
		['proyecto_id', 'hidden']
	]

	belongs_to :proyecto

	has_many :tablas, foreign_key: 'padre_id', class_name: 'Tabla'
	has_many :documentos
end
