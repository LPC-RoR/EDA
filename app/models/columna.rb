class Columna < ApplicationRecord
	TABLA_FIELDS = [
		['orden',     'normal'],
		['columna',       'show']
	]

	# -------------------- FORM  -----------------------
 	FORM_FIELDS = [
		['orden',        'entry'],
		['columna',        'entry'],
		['linea_id', 'hidden']
	]

	belongs_to :linea

end
