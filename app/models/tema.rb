class Tema < ApplicationRecord
	# ----------------------------------------- HIDDEN CHILDS
	HIDDEN_CHILDS = ['clasificaciones']

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

	belongs_to :investigador

	has_many :clasificaciones
	has_many :textos, through: :clasificaciones

end
