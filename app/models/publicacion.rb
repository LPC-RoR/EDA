class Publicacion < ApplicationRecord

	NOMBRES_BIB = ["Author", "Title", "Year", "Volume", "Month", "Abstract", "Publisher", "Address", "Affiliation", "DOI", "Article-Number", "ISSN", "EISSN", "Keywords", "Keywords-Plus", "Research-Areas", "Web-of-Science-Categories", "Author-Email", "Unique-ID", "DA"]

	D_TABLA = {
		titulo:  true,
		tabs:    false,
		paginas: true,
		estados: false,
		nuevo:   true
	}

	TABLA_FIELDS = [
		['title',         'show'], 
		['year',        'normal']
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

	D_SHOW = {
		titulo:   true,
		nav:      false,
		detalle:  true,
		tabs:     false,
		adjuntos: false,
		tablas:   false
	}

	SHOW_FIELDS = [
		['year',       'normal'], 
		['author',     'normal'], 
		['odi',        'normal'],
		['abstract',   'normal']
	]

	belongs_to :registro, optional: true
	belongs_to :revista, optional: true

	has_many :citas
	has_many :textos, through: :citas

	has_many :autores
	has_many :investigadores, through: :autores

	has_many :procesos
	has_many :cargas, through: :procesos

	def show_title
		self.title
	end

end
