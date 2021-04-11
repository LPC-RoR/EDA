class Publicacion < ApplicationRecord

	attr_accessor :despliegue

	NOMBRES_BIB = ["Author", "Title", "Type", "Year", "Volume", "Pages", "Month", "Number", "Note", "Series", "Meeting", "Note", "Abstract", "Publisher", "Editor", "Booktitle", "Address", "Affiliation", "DOI", "Article-Number", "ISSN", "EISSN", "Keywords", "Keywords-Plus", "Research-Areas", "Web-of-Science-Categories", "Author-Email", "Unique-ID", "DA"]

	DOC_TYPES	 = ['Article', 'Book', 'Tesis', 'Memoir', 'Chapter', 'Generic']

	EVALUACION = {
		'Objetivos' =>             ['delineados', 'confusos'],
		'Metodología' => ['fuerte', 'debil', 'controversial'],
		'Resultado' =>  ['significativo', 'no significativo'],
		'Conclusiones' =>    ['aceptadas', 'controversiales']
	}

	# Campos qeu se despliegan en la tabla
	TABLA_FIELDS = [
		['title',       'show'], 
		['d_type',    'normal'], 
		['year',      'normal']
	]

# -------------------- SHOW -------------------------
	SHOW_FIELDS = [
		['type_quote',         'metodo'], 
		['d_author',        'normal'], 
		['author',          'normal'], 
		['year',            'normal'], 
		['title',           'normal'],
		['editor',          'normal'],
		['book',            'normal'],
		['academic_degree', 'normal'],
		['ciudad_pais',     'normal'],
		['d_journal',       'normal'],
		['journal',         'normal'],
		['volume',          'normal'],
		['pages',           'normal'],
		['d_doi',           'normal'],
		['doi',             'normal']
	]

	belongs_to :registro, optional: true
	belongs_to :revista, optional: true

	has_many :evaluaciones

	has_many :citas
	has_many :textos, through: :citas

	has_many :autores
	has_many :investigadores, through: :autores

	has_many :procesos
	has_many :cargas, through: :procesos

	has_many :clasificaciones
	has_many :carpetas, through: :clasificaciones

	has_many :asociaciones
	has_many :proyectos, through: :asociaciones

	has_many :etq_contadores
	has_many :etiquetas, through: :etq_contadores

	# PENDIENTE DE REVISIÓN
#	has_many :asignaciones, foreign_key: 'paper_id', class_name: 'Clasificacion'
#	has_many :areas, through: :asignaciones

	# PENDIENTE DE EVALUAR: Enrutamiento Conceptual
#	has_many :rutas
#	has_many :instancias, through: :rutas

	def m_quote
#		autores = self.d_author.present? ? procesa_autores(self.author) : self.author
		autores = self.author
		case self.doc_type
		when 'Article'
			"#{autores} (#{self.year}) <b>#{self.title}</b>#{"." unless ['?', '-'].include?(self.title[-1])} #{self.q_journal} #{self.volume}: #{self.pages} #{"doi: " if self.doi.present?}#{self.doi}".strip+'.'
		when 'Book'
			"#{autores}#{", #{self.editor} (Ed.)" unless self.editor.blank?} (#{self.year}) <b>#{self.title}</b>#{"." unless ['?', '-'].include?(self.title[-1])} #{"#{self.ciudad_pais}: " unless self.ciudad_pais.blank?}#{self.q_journal} #{self.pages}#{" pp" if self.pages.present?} #{"doi: " if self.doi.present?}#{self.doi}".strip+'.'
		when 'Tesis'
			"#{autores} (#{self.year}) <b>#{self.title}</b>#{"." unless ['?', '-'].include?(self.title[-1])} Tesis #{self.q_journal} #{self.pages}#{"pp" if self.pages.present?} #{"doi: " if self.doi.present?}#{self.doi}".strip+'.'
		when 'Memoir'
			"#{autores} (#{self.year}) <b>#{self.title}</b>#{"." unless ['?', '-'].include?(self.title[-1])} Memoria para optar al Título Profesional de #{self.academic_degree}, #{self.q_journal} #{self.pages}#{"pp" if self.pages.present?} #{"doi: " if self.doi.present?}#{self.doi}".strip+'.'
		when 'Chapter'
			"#{autores} (#{self.year}) <b>#{self.title}</b>#{"." unless ['?', '-'].include?(self.title[-1])} En: #{"#{self.editor} (Ed.), " unless self.editor.blank?}#{self.book} (pp #{self.pages}). #{self.ciudad_pais}#{": " unless self.ciudad_pais.blank?}#{self.q_journal}. #{"doi: " if self.doi.present?}#{self.doi}".strip
		when 'Generic'
			"#{autores} (#{self.year}) <b>#{self.title}</b>#{"." unless ['?', '-'].include?(self.title[-1])} #{self.q_journal} #{self.pages}#{" pp" if self.pages.present?} #{"doi: " if self.doi.present?}#{self.doi}".strip+'.'
		end
	end

	def author_year
		"#{self.author} (#{self.year.blank? ? 'not yet published' : self.year})"
	end

	def q_journal
		self.revista.present? ? self.revista.revista : 'sin información'
	end

	def labeled_doi
		"doi: #{self.doi}"
	end

	def detail
		series = (self.series.blank? ? '' : self.series)
		volume = (self.volume.blank? ? '' : " #{self.volume}")
		month = (self.month.blank? ? '' : " #{self.month}")
		pages = (self.pages.blank? ? '' : " : #{self.pages}")
		"#{series}#{volume}#{month}#{pages}"
	end

	def type_quote
		tipo_publicacion = TipoPublicacion.find_by(tipo_publicacion: self.doc_type)
		if tipo_publicacion.redireccion.present?
			redireccion = tipo_publicacion.redireccion
			tipo_publicacion = TipoPublicacion.find_by(tipo_publicacion: redireccion)
		end
		if tipo_publicacion.blank?
			''
		else
			if tipo_publicacion.campos.empty?
				tipo_publicacion = TipoPublicacion.find_by(tipo_publicacion: self.doc_type.split(';').first)
			end
			quote = ''
			tipo_publicacion.campos.order(:orden).each do |campo|
				espacio = (quote == '' or self.send(campo.campo).blank?) ? '' : ' '
				quote += "#{espacio}#{'<i>' if campo.cursiva}#{'<b>' if campo.negrita}#{self.send(campo.campo)}#{'</b>' if campo.negrita}#{'</i>' if campo.cursiva}#{'.' if campo.dot and self.send(campo.campo).present?}"
			end
			quote
		end
	end

	def d_type
		self.doc_type
	end

	def evaluable
		# 1.- Esta en la carpeta 'Aceptadas'
		self.carpetas.map {|car| car.carpeta}.include?('Aceptadas') or (self.carpetas.map {|car| car.carpeta} & Carpeta::NOT_MODIFY).empty?
	end

	def duplicados
	    duplicados_doi_ids = self.doi.present? ? (Publicacion.where(doi: self.doi).ids - [self.id]) : []
	    duplicados_t_sha1_ids = self.title.present? ? (Publicacion.where(t_sha1: self.t_sha1).ids - [self.id]) : []
	    duplicados_ids = duplicados_doi_ids.union(duplicados_t_sha1_ids)

	    Publicacion.where(id: duplicados_ids)
	end

	def en_seleccion?
		nombres_carpetas = self.carpetas.map {|car| car.carpeta}
		self.carpetas.count == 1 and (['Carga', 'Ingreso', 'Duplicadas'] & nombres_carpetas).any?
	end

	def primer_destino?
		self.carpetas.count == 1 and ['Postergadas', 'Excluidas'].include?(self.carpetas.first.carpeta)
	end

	def en_proceso?
		self.carpetas.count == 1 and self.carpetas.first.carpeta == 'Aceptadas'
	end

	def procesada?
		nombres_carpetas = self.carpetas.map {|car| car.carpeta}
		(Carpeta::NOT_MODIFY & nombres_carpetas).empty?
	end

end
