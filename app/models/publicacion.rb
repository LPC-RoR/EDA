class Publicacion < ApplicationRecord

	NOMBRES_BIB = ["Author", "Title", "Year", "Volume", "Month", "Abstract", "Publisher", "Address", "Affiliation", "DOI", "Article-Number", "ISSN", "EISSN", "Keywords", "Keywords-Plus", "Research-Areas", "Web-of-Science-Categories", "Author-Email", "Unique-ID", "DA"]

	EVALUACION = {
		'Objetivos' =>             ['delineados', 'confusos'],
		'Metodología' => ['fuerte', 'debil', 'controversial'],
		'Resultado' =>  ['significativo', 'no significativo'],
		'Conclusiones' =>    ['aceptadas', 'controversiales']
	}

	# ------------------- TABLA -----------------------
	TABS = Carpeta.all.map {|c| c.carpeta}

	## CORREGIDO
	# Configura DESPLIEGUE de la TABLA
	T_EXCEPTIONS = {
		tabs:    ['self'],
		paginas: ['*'],
		nuevo:   ['self', 'recursos', 'equipos']
	}

	# Campos qeu se despliegan en la tabla
	TABLA_FIELDS = [
		['title',         'show'], 
		['year',        'normal']
	]

	# -------------------- FORM  -----------------------
	SHOW_EXCEPTIONS = [:clasifica, :detalle, :inline_form]

 	FORM_FIELDS = [
		['d_journal',    'entry'],
		['title',        'entry'],
		['d_author',    'entry'],
		['d_doi',        'entry'],
		['abstract', 'text_area']
	]

	# -------------------- SHOW -------------------------
	SHOW_FIELDS = [
		['year',       'normal'], 
		['author',     'normal'], 
		['doi',        'normal'],
		['abstract',   'normal']
	]

	# --------------------- DESPLIEGUE -------------------------
	# tablas child que NO deben ser deplegadas
	HIDDEN_CHILDS = ['citas', 'autores', 'investigadores', 'procesos', 'cargas', 'clasificaciones', 'carpetas', 'evaluaciones']

	SHOW_BT_OBJECTS = ['revista']
	SHOW_HMT_COLLECTIONS = ['cargas', 'investigadores']

	belongs_to :registro, optional: true
	belongs_to :revista, optional: true
	belongs_to :equipo, optional: true
	belongs_to :investigador, optional: true

	has_many :evaluaciones
	has_many :metodologias

	has_many :citas
	has_many :textos, through: :citas

	has_many :autores
	has_many :investigadores, through: :autores

	has_many :procesos
	has_many :cargas, through: :procesos

	has_many :clasificaciones
	has_many :carpetas, through: :clasificaciones

	def show_links
		[
		]
	end

	def btns_control
		['ingreso', 'produccion'].include?(self.origen)
	end
end
