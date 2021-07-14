class CampoCarga < ApplicationRecord

	TABLA_FIELDS = [
		['campo_carga', 'normal'],
		['campo_tabla', 'normal']
	]

 	FORM_FIELDS = [
		['campo_carga',       'entry'],
		['campo_tabla',       'entry'],
		['formato_carga_id', 'hidden']
	]

	belongs_to :formato_carga
end
