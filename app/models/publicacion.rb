class Publicacion < ApplicationRecord

	NOMBRES_BIB = ["Author", "Title", "Type", "Year", "Volume", "Month", "Abstract", "Publisher", "Address", "Affiliation", "DOI", "Article-Number", "ISSN", "EISSN", "Keywords", "Keywords-Plus", "Research-Areas", "Web-of-Science-Categories", "Author-Email", "Unique-ID", "DA"]

	DOC_TYPES	 = ['Article', 'Book', 'Tesis', 'Memoir', 'Chapter', 'Generic']

	EVALUACION = {
		'Objetivos' =>             ['delineados', 'confusos'],
		'Metodología' => ['fuerte', 'debil', 'controversial'],
		'Resultado' =>  ['significativo', 'no significativo'],
		'Conclusiones' =>    ['aceptadas', 'controversiales']
	}

	# ------------------- TABLA -----------------------
	TABS = Carpeta.all.map {|c| c.carpeta}

	# ----------------------------------------- HIDDEN CHILDS
	HIDDEN_CHILDS = ['citas', 'autores', 'investigadores', 'procesos', 'cargas', 'clasificaciones', 'carpetas', 'evaluaciones']

	FRAME_TITULO = {
		'index'      => 'Publicaciones'
	}

	FRAME_SELECTOR = {
		'index'      => 'Carpetas'
	}

	FRAME_ACTIONS_TYPE = {
		'index'      => 'tabla'
#		'parametros' => 'valor'
	}

	# Configura DESPLIEGUE de la TABLA
	T_EXCEPTIONS = {
		titulo:    ['self'],
		paginas: ['*'],
		nuevo:   ['self', 'ingresos', 'equipos']
	}

	# Campos qeu se despliegan en la tabla
	TABLA_FIELDS = [
		['title',         'show'], 
		['doc_type',    'normal'], 
		['year',        'normal']
	]

	# -------------------- FORM  -----------------------
	SHOW_EXCEPTIONS = [:clasifica, :detalle, :inline_form]

	## AL PARECER ESTO YA HO SE USARÁ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! VERIFICAR !!
	T_NEW_EXCEPTIONS = {
		#'controller' => 'tipo_new'
		# '*' en todo controller_name
		'*' => 'mask',
	}

	# -------------------- FORM  -----------------------

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

	FORM_CONDITIONAL_FIELDS = ['d_quote', 'm_quote', 'doi', 'd_author', 'd_doi', 'abstract', 'academic_degree', 'volume', 'book', 'pages', 'd_journal', 'title', 'year', 'author', 'editor', 'ciudad_pais', 'journal']

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

	S_E = [:clasifica, :detalle, :inline_form]

	# LINKS !!
	S_BT_LINKS_OBJECTS = ['Revista']
	S_HMT_LINKS_COLLECTIONS = ['investigadores']

	belongs_to :registro, optional: true
	belongs_to :revista, optional: true
	belongs_to :equipo, optional: true
	belongs_to :perfil, optional: true
	# En esta versión NO exploramos la clasificación por áreas
	# QUEDA PENDIENTE
#	belongs_to :area, optional: true

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

	# PENDIENTE DE REVISIÓN
#	has_many :asignaciones, foreign_key: 'paper_id', class_name: 'Clasificacion'
#	has_many :areas, through: :asignaciones

	# PENDIENTE DE EVALUAR: Enrutamiento Conceptual
#	has_many :rutas
#	has_many :instancias, through: :rutas

	def show_title
		self.title
	end

	## 1.- Ingresos: Publicar, Corregir, Papelera, Eliminar, Editar
	def show_links
		[
			['Editar',     [:edit, self], self.origen == 'ingreso'],
			['Papelera',   "/publicaciones/estado?publicacion_id=#{self.id}&estado=papelera",     ['ingreso', 'duplicado', 'carga', 'formato', 'contribucion'].include?(self.estado)],
			['Eliminar',   "/publicaciones/estado?publicacion_id=#{self.id}&estado=eliminado",    ['papelera'].include?(self.estado)],
			['Publicar',   "/publicaciones/estado?publicacion_id=#{self.id}&estado=publicada",    (['ingreso'].include?(self.estado) and self.title.present? and self.author.present? and self.journal.present?)],	
			['Carga',      "/publicaciones/estado?publicacion_id=#{self.id}&estado=carga",        (['publicado', 'papelera'].include?(self.estado) and self.origen == 'carga')],
			['Ingreso',    "/publicaciones/estado?publicacion_id=#{self.id}&estado=ingreso",        (['publicado', 'papelera'].include?(self.estado) and self.origen == 'ingreso')],
			['Múltiple',   "/publicaciones/estado?publicacion_id=#{self.id}&estado=multiple",     self.estado == 'duplicado'],
			['Corrección', "/publicaciones/estado?publicacion_id=#{self.id}&estado=correccion",   (self.estado == 'publicada' and self.origen == 'ingreso' and self.textos.empty?)]
		]
		
	end

	def btns_control
		self.origen == 'ingreso'
	end
	# ANTIGUO
#	def btns_control
#		['ingreso', 'produccion'].include?(self.origen)
#	end

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

	def c_d_quote
		# Sólo duplicados de origen carga, las publicaciones de 'ingreso' no tienen cita
		self.origen == 'ingreso'
	end
	def c_m_quote
		['carga', 'ingreso', 'duplicado', 'formato'].include?(self.estado)
	end
	def c_doi
		['carga', 'ingreso', 'duplicado', 'formato'].include?(self.estado)
	end
	def c_d_author
		['carga', 'ingreso', 'duplicado', 'formato', 'contribucion'].include?(self.estado)
	end
	def c_d_doi
		self.estado == 'ingreso'
	end
	def c_abstract
		self.estado == 'ingreso'
	end
	def c_academic_degree
		['carga', 'ingreso', 'duplicado', 'formato'].include?(self.estado)
	end
	def c_volume
		['carga', 'ingreso', 'duplicado', 'formato'].include?(self.estado)
	end
	def c_book
		['carga', 'ingreso', 'duplicado', 'formato'].include?(self.estado)
	end
	def c_editor
		['carga', 'ingreso', 'duplicado', 'formato'].include?(self.estado)
	end
	def c_pages
		['carga', 'ingreso', 'duplicado', 'formato'].include?(self.estado)
	end
	def c_d_journal
		['carga', 'ingreso', 'duplicado', 'formato'].include?(self.estado)
	end
	def c_title
		['carga', 'ingreso', 'duplicado', 'formato'].include?(self.estado)
	end
	def c_year
		['carga', 'ingreso', 'duplicado', 'formato'].include?(self.estado)
	end
	def c_author
		['carga', 'ingreso', 'duplicado', 'formato'].include?(self.estado)
	end
	def c_ciudad_pais
		self.origen == 'ingreso' and self.estado == 'ingreso'
	end
	def c_journal
		self.origen == 'ingreso' and self.estado == 'ingreso'
	end
end
