class Publicacion < ApplicationRecord

	NOMBRES_BIB = ["Author", "Title", "Year", "Volume", "Month", "Abstract", "Publisher", "Address", "Affiliation", "DOI", "Article-Number", "ISSN", "EISSN", "Keywords", "Keywords-Plus", "Research-Areas", "Web-of-Science-Categories", "Author-Email", "Unique-ID", "DA"]

	# tablas child que NO deben ser deplegadas
	HIDDEN_CHILDS = ['citas', 'autores', 'investigadores', 'procesos', 'cargas']

	# ------------------- TABLA -----------------------
	# Configura DESPLIEGUE de la TABLA
	D_TABLA = {
		tabs:    false,
		paginas: true,
		estados: false,
		nuevo:   true
	}

	# Campos qeu se despliegan en la tabla
	TABLA_FIELDS = [
		['title',         'show'], 
		['year',        'normal']
	]

	# Tipo de LINK boton NUEVO
	TIPO_NEW = 'new'

	# Acceso a campos BT
#	BT_FIELDS = []	
#	BT_MODEL = ''

	# -------------------- FORM  -----------------------
 	FORM_FIELDS = [
		['d_journal',    'entry'],
		['title',        'entry'],
		['d_author',    'entry'],
		['d_doi',        'entry'],
		['abstract', 'text_area']
	]

	D_SHOW = {
		titulo:      true,
		links:       true,
		nav:         false,
		detalle:     true,
		inline_form: true,
		tabs:        true,
		adjuntos:    false,
		tablas:      false
	}

	SHOW_FIELDS = [
		['year',       'normal'], 
		['author',     'normal'], 
		['doi',        'normal'],
		['abstract',   'normal']
	]

	SHOW_BT_OBJECTS = ['revista']
	SHOW_HMT_COLLECTIONS = ['cargas', 'investigadores']

	belongs_to :registro, optional: true
	belongs_to :revista, optional: true

	has_many :citas
	has_many :textos, through: :citas

	has_many :autores
	has_many :investigadores, through: :autores

	has_many :procesos
	has_many :cargas, through: :procesos

	def show_links
		[
		]
	end
	def show_title
		self.title
	end
end
