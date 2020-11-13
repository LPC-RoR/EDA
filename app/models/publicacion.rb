class Publicacion < ApplicationRecord

	D_TABLA = {
		titulo:  true,
		tabs:    false,
		paginas: false,
		estados: false,
		nuevo:   true
	}

	TABLA_FIELDS = [
		['titulo',         'show'], 
		['annio',        'normal']
	]

	TIPO_NEW = 'new'

 	FORM_FIELDS = [
		['detalle_revista',           'entry'],
		['titulo',                    'entry'],
		['detalle_autores',           'entry'],
		['doi',                       'entry'],
		['detalle_instituciones', 'text_area'],
		['keywords',              'text_area'],
		['fechas',                'text_area']
	]

	belongs_to :carga, optional: true

	belongs_to :registro, optional: true
	belongs_to :revista, optional: true

	has_many :textos
	has_many :metodologias

	has_many :autores
	has_many :investigadores, through: :autores

	has_many :origenes
	has_many :repositorios, through: :origenes

	has_many :referencias
	has_many :conceptos, through: :referencias
end
