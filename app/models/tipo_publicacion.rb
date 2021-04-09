class TipoPublicacion < ApplicationRecord
	TABLA_FIELDS = [
		['tipo_publicacion', 'show'],
		['redireccion',    'normal']
	]

 	FORM_FIELDS = [
		['tipo_publicacion',  'entry'],
		['redireccion',       'entry']
	]

	has_many :campos

end
