class Investigador < ApplicationRecord
	# --------------------------------------------------- TABLA
	TABLA_FIELDS = [
		['investigador',         'show']
	]

	belongs_to :departamento, optional: true

	has_one :perfil

	has_many :autores
	has_many :publicaciones, through: :autores

end
