class Publicacion < ApplicationRecord

	NOMBRES_BIB = ["Author", "Title", "Type", "Year", "Volume", "Month", "Abstract", "Publisher", "Address", "Affiliation", "DOI", "Article-Number", "ISSN", "EISSN", "Keywords", "Keywords-Plus", "Research-Areas", "Web-of-Science-Categories", "Author-Email", "Unique-ID", "DA"]

	DOC_TYPES	 = ['Article', 'Book', 'Tesis', 'Memoir', 'Chapter', 'Generic']

	EVALUACION = {
		'Objetivos' =>             ['delineados', 'confusos'],
		'Metodología' => ['fuerte', 'debil', 'controversial'],
		'Resultado' =>  ['significativo', 'no significativo'],
		'Conclusiones' =>    ['aceptadas', 'controversiales']
	}

	# Campos qeu se despliegan en la tabla
	TABLA_FIELDS = [
		['title',         'show'], 
		['doc_type',    'normal'], 
		['year',        'normal']
	]

 	FORM_FIELDS = [
		['d_quote',          'show'], 
		['doc_type',       'normal'], 
		['m_quote',        'metodo'], 
		['d_author',        'entry'],
		['author',          'entry'], 
		['year',            'entry'], 
		['title',           'entry'],
		['editor',          'entry'],
		['book',            'entry'],
		['academic_degree', 'entry'],
		['ciudad_pais',     'entry'],
		['d_journal',       'entry'],
		['volume',          'entry'],
		['pages',           'entry'],
		['d_doi',           'entry'],
		['doi',             'entry'],
		['abstract',    'text_area'],

		['estado',         'hidden']
	]

	# -------------------- SHOW -------------------------
	SHOW_FIELDS = [
		['m_quote',         'metodo'], 
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
	belongs_to :perfil, optional: true
	# En esta versión NO exploramos la clasificación por áreas
	# QUEDA PENDIENTE
#	belongs_to :area, optional: true

	has_many :evaluaciones

	has_many :citas
	has_many :textos, through: :citas

	has_many :autores
	has_many :investigadores, through: :autores

	has_many :procesos
	has_many :cargas, through: :procesos

	has_many :clasificaciones
	has_many :carpetas, through: :clasificaciones

	# PENDIENTE DE REVISIÓN
#	has_many :asignaciones, foreign_key: 'paper_id', class_name: 'Clasificacion'
#	has_many :areas, through: :asignaciones

	# PENDIENTE DE EVALUAR: Enrutamiento Conceptual
#	has_many :rutas
#	has_many :instancias, through: :rutas

	# REVISAR SI SE USARÁ
	def procesa_autor(author, ind)
		# SE DEBE PROCESAR
		if self.c_d_author.present?
			elementos = author.split(' ')

			case elementos.length
			when 1
				# Es el apellido
				author.strip.upcase
			when 2
				if elementos[0] == elementos[0].upcase
					if elementos[0].length < elementos[1].length
						(ind == 0 ? "#{elementos[1].upcase} #{elementos[0].upcase}" : "#{elementos[0].upcase} #{elementos[1].upcase}" )
					else
						(ind == 0 ? "#{elementos[0].upcase} #{elementos[1].upcase}" : "#{elementos[1].upcase} #{elementos[0].upcase}" )
					end
				else
					(ind == 0 ? "#{elementos[1].upcase} #{elementos[0][0].upcase}" : "#{elementos[0][0].upcase} #{elementos[1].upcase}" )
				end
			when 3
				(ind == 0 ? "#{elementos[2].upcase} #{elementos[0][0].upcase}#{elementos[1].upcase}" : "#{elementos[0][0].upcase}#{elementos[1].upcase} #{elementos[2].upcase}")
			else
				(ind == 0 ? "#{elementos.last.upcase} #{elementos[0..-2].map {|i| i[0]}.join('')}" : "#{elementos[0..-2].map {|i| i[0]}.join('')} #{elementos.last.upcase}")
			end
		end
	end
	def procesa_autores(author)
		ultimo = procesa_autor(author.split(' &').last, 666)

		primeros = author.split(' & ')[0].split(', ')
		primeros_ok = []
		primeros.each_with_index do |aut, i|
			primeros_ok << procesa_autor(aut, i)
		end
		primeros_ok.join(', ')+' & '+ultimo
	end

	def m_quote
		autores = self.d_author.present? ? procesa_autores(self.author) : self.author
		case self.doc_type
		when 'Article'
			"#{autores} (#{self.year}) #{self.title}#{"." unless ['?', '-'].include?(self.title[-1])} #{self.journal} #{self.volume}: #{self.pages} #{"doi: " if self.doi.present?}#{self.doi}".strip+'.'
		when 'Book'
			"#{autores}#{", #{self.editor} (Ed.)" unless self.editor.blank?} (#{self.year}) #{self.title}#{"." unless ['?', '-'].include?(self.title[-1])} #{"#{self.ciudad_pais}: " unless self.ciudad_pais.blank?}#{self.journal} #{self.pages}#{" pp" if self.pages.present?} #{"doi: " if self.doi.present?}#{self.doi}".strip+'.'
		when 'Tesis'
			"#{autores} (#{self.year}) #{self.title}#{"." unless ['?', '-'].include?(self.title[-1])} Tesis #{self.journal} #{self.pages}#{"pp" if self.pages.present?} #{"doi: " if self.doi.present?}#{self.doi}".strip+'.'
		when 'Memoir'
			"#{autores} (#{self.year}) #{self.title}#{"." unless ['?', '-'].include?(self.title[-1])} Memoria para optar al Título Profesional de #{self.academic_degree}, #{self.journal} #{self.pages}#{"pp" if self.pages.present?} #{"doi: " if self.doi.present?}#{self.doi}".strip+'.'
		when 'Chapter'
			"#{autores} (#{self.year}) #{self.title}#{"." unless ['?', '-'].include?(self.title[-1])} En: #{"#{self.editor} (Ed.), " unless self.editor.blank?}#{self.book} (pp #{self.pages}). #{self.ciudad_pais}#{": " unless self.ciudad_pais.blank?}#{self.journal}. #{"doi: " if self.doi.present?}#{self.doi}".strip
		when 'Generic'
			"#{autores} (#{self.year}) #{self.title}#{"." unless ['?', '-'].include?(self.title[-1])} #{self.journal} #{self.pages}#{" pp" if self.pages.present?} #{"doi: " if self.doi.present?}#{self.doi}".strip+'.'
		end
	end

end
