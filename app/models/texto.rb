class Texto < ApplicationRecord
	# ------------------------------------------ TABLA
	TABLA_FIELDS = [
		['texto',   'show']
	]

	TABLE_EXCEPTIONS = {
		nuevo:   {'self' => true}
	 	}

 	FORM_FIELDS = [
		['texto',           'entry']
	]

	# ------------------------------------------ SHOW
	SHOW_EXCEPTIONS = [:inline_form, :tabla]

	# ------------------------------------------ DESPLIEGUE
	HIDDEN_CHILDS = ['clasificaciones', 'citas']

	SHOW_HMT_COLLECTIONS = ['temas', 'publicaciones']

	has_many :clasificaciones
	has_many :temas, through: :clasificaciones

	has_many :citas
	has_many :publicaciones, through: :citas

end
