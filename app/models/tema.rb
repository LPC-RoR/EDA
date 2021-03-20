class Tema < ApplicationRecord

	TABLA_FIELDS = [
		['tema',         'show']
	]

	# -------------------- FORM  -----------------------
 	FORM_FIELDS = [
		['tema',             'entry'],
		['perfil_id',       'hidden']
	]

	has_many :clasificaciones
	has_many :textos, through: :clasificaciones

	has_many :herencias
	has_many :carpetas, through: :herencias

end
