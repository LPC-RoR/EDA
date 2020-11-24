class Metodologia < ApplicationRecord
	TABLA_FIELDS = [
		['orden',         'normal'], 
		['metodologia',   'normal']
	]

	belongs_to :publicacion
end
