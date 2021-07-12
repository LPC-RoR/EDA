class Sumario < ApplicationRecord

	TABLA_FIELDS = [
		['clave', 'normal'],
		['valor', 'normal']
	]

	belongs_to :encabezado
end
