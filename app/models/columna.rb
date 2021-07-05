class Columna < ApplicationRecord

 	FORM_FIELDS = [
		['columna',      'entry'],
		['orden',       'hidden'],
		['linea_id',    'hidden']
	]

	belongs_to :linea
end
