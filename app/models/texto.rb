class Texto < ApplicationRecord
	# ----------------------------------------- HIDDEN CHILDS
	HIDDEN_CHILDS = ['clasificaciones', 'citas']

	# ------------------------------------------ TABLA
	TABLA_FIELDS = [
		['texto',   'show']
	]

	T_EXCEPTIONS = {
		nuevo:    ['self']
	}

 	FORM_FIELDS = [
		['texto',           'entry']
	]

	# ------------------------------------------ SHOW
	SHOW_EXCEPTIONS = [:inline_form, :tabla]

	# ------------------------------------------ DESPLIEGUE

	SHOW_HMT_COLLECTIONS = ['temas', 'publicaciones']

	has_many :clasificaciones
	has_many :temas, through: :clasificaciones

	has_many :citas
	has_many :publicaciones, through: :citas

end
