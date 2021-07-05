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

	has_many :documentos

	def tablas
		Tabla.where(padre_class: 'Etapa').where(padre_id: self.id)
	end
end
