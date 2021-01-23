class Investigador < ApplicationRecord
	# ----------------------------------------- HIDDEN CHILDS
	HIDDEN_CHILDS = ['autores']

	# --------------------------------------------------- TABLA
	TABLA_FIELDS = [
		['investigador',         'show']
	]

	# ---------------------------------------------------- SHOW
	# ES PROBABLE QUE NO LO NECESITE MAS !!!!!!
	D_SHOW = {
		links:        true,
		detalle:     false,
		clasifica:   false,
		inline_form: false,
		tabla:        true,
		adjuntos:    false
	}

	belongs_to :departamento, optional: true

	has_one :perfil

	has_many :autores
	has_many :publicaciones, through: :autores

end
