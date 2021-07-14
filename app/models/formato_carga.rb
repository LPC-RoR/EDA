class FormatoCarga < ApplicationRecord

	TABLA_FIELDS = [
		['formato_carga', 'show']
	]

 	FORM_FIELDS = [
		['formato_carga',      'entry']
	]
	
	has_many :campo_cargas
end
