class Tema < ApplicationRecord
	# ------------------- TABLA -----------------------

	# Campos qeu se despliegan en la tabla
	TABLA_FIELDS = [
		['tema',         'show']
	]

	# -------------------- FORM  -----------------------
 	FORM_FIELDS = [
		['tema',             'entry'],
		['investigador_id', 'hidden']
	]

	# --------------------------------------- DESPLIEGUE
	HIDDEN_CHILDS = ['clasificaciones']

	belongs_to :investigador

	has_many :clasificaciones
	has_many :textos, through: :clasificaciones

end
