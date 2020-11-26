class Metodologia < ApplicationRecord
	#-------------------------------------------------- TABLA
	TABLA_FIELDS = [
		['orden',         'normal'], 
		['metodologia',   'normal']
	]

	belongs_to :publicacion
end
