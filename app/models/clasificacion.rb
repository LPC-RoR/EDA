class Clasificacion < ApplicationRecord
	CLASIFICACION = ['referencia', 'complementario', 'controversial', 'revisar']

	TABLA_FIELDS = [
		['clasificacion', 'normal'],
		['texto',         'normal']
	]

	belongs_to :carpeta, optional: true
	belongs_to :tema, optional: true
	belongs_to :publicacion, optional: true
	belongs_to :texto, optional: true

end
