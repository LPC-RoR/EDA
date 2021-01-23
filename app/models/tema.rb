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
		['perfil_id',       'hidden']
	]

	# --------------------------------------- DESPLIEGUE

	belongs_to :perfil

	has_many :clasificaciones
	has_many :textos, through: :clasificaciones

end
