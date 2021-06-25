class Encabezado < ApplicationRecord

	TIPOS = ['texto', 'valor', 'link']

 	FORM_FIELDS = [
		['encabezado', 'entry'],
		['tipo',       'entry'],
		['tabla_id',  'hidden']
	]

	belongs_to :tabla
end
