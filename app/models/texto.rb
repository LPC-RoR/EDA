class Texto < ApplicationRecord

	TABLA_FIELDS = [
		['texto',   'show']
	]

	has_many :clasificaciones
	has_many :temas, through: :clasificaciones

	has_many :citas
	has_many :publicaciones, through: :citas

end
