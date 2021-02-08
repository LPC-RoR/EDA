class Observacion < ApplicationRecord

	TABLA_FIELDS = [
		['orden',     'normal'],
		['observacion', 'show']
	]

	# -------------------- FORM  -----------------------
 	FORM_FIELDS = [
		['orden',       'entry'],
		['observacion', 'entry'],
		['etapa_id',   'hidden']
	]

	belongs_to :columna, optional: true
	belongs_to :linea, optional: true
	belongs_to :tabla, optional: true
end
