module ProcesaCarga
	extend ActiveSupport::Concern

	# cargas_controller.rb
	def carga_archivo_bib(carga)

		if carga.estado == 'ingreso'

			proyecto_activo = Proyecto.find(session[:proyecto_activo]['id'])

			## ABRE ARCHIVO
	 	    @file = File.open("#{Rails.root}/public/#{carga.archivo_carga.url}")
		    # Lee el archivo
		    @file_data = @file.read

		    n_procesados = 0 # TOTAL de artículos procesados
		    n_nuevos     = 0 # Publicaciones NUEVAS que se integraron a la colección de publicaciones
		    n_duplicados = 0 # Criterio DUPLICADOS ('titulo'), revisar con CVCH
		    n_vinculados = 0 # Publicaciones de OTRO USUARIO que se VINCULO a la colección del USUARIO
		    n_existentes = 0 # Publicaciones REPETIDAS. NO se consideraron
		    @contador = 0

		    elementos = procesa_archivo_bib(@file_data)

		    elementos.each do |hash_articulo|
		    	n_procesados += 1
		    	@contador += 1

		    	# Control de 'Type'
		    	tipo_publicacion = TipoPublicacion.find_by(tipo_publicacion: hash_articulo['Type'])
		    	if tipo_publicacion.blank?
		    		TipoPublicacion.create(tipo_publicacion: hash_articulo['Type'], ejemplo: hash_articulo)
		    	end

		    	## UNICIDAD
		    	# Luego evaluamos la unicidad del árticulo {}
		    	unicidad = (carga.refill ? 'remplazar_carga' : unicidad_publicacion_carga(hash_articulo))

		    	if ['remplazar_carga', 'sin carpeta'].include?(unicidad)
		      		pub = Publicacion.find_by(unique_id: hash_articulo['Unique-ID'])
		      	elsif ['nuevo', 'colision_titulo'].include?(unicidad)
		      		pub = Publicacion.new
		      	elsif unicidad == 'remplazar_doi'
		      		pub = Publicacion.find_by(doi: hash_articulo['DOI'])
		    	end

		    	if pub.blank?
		    		unicidad = 'saltar'
		    	end

		    	# llenado desde hash para los registros vacíos o por corregir
		    	if ['remplazar_carga', 'remplazar_doi', 'nuevo', 'colision_titulo'].include?(unicidad)
			        Publicacion::NOMBRES_BIB.each do |bib|
			        	nombre_campo = ( bib == 'Type' ? 'doc_type' : bib.downcase.split('-').join('_') )
			        	valor_campo = ( bib == 'Abstract' ? hash_articulo[bib] : ( hash_articulo[bib].blank? ? '' : hash_articulo[bib].gsub('\\', '') ) )
			        	pub.write_attribute( nombre_campo, valor_campo )
			        end
			        pub.origen = 'WOS_bib'
			        pub.t_sha1 = Digest::SHA1.hexdigest(pub.title)
		    	end

		    	# BORRAR REVISTA Y AUTORES
		    	# Los ingresos manuales no llenan el IDIOMA
		    	if unicidad == 'remplazar_doi'
		      		r = pub.revista
		      		unless r.blank?
		      			r.publicaciones.delete(pub) 
			      		r.delete if pub.revista.publicaciones.count == 0
			      	end

			      	pub.investigadores.each do |i|
		      			pub.investigadores.delete(i)
		      			i.delete if i.publicaciones.count == 0
			      	end
		    	end

		    	# LLENAR IDIOMA + REVISTA
		    	# Agregamos 'remplazar_carga' para cubrir el refill, la reparación de registros
		    	if ['remplazar_carga', 'remplazar_doi', 'nuevo', 'colision_titulo'].include?(unicidad)
		    		# REFILL
		    		if hash_articulo['Language'].blank?
		    			idio = Idioma.find_by(idioma: '')
		    			unless idio.blank?
		    				idio.idioma = 'sin información'
		    				idio.save
		    			end
		    		end
			        # Agrega IDIOMA -> REVISTA
			        idioma = ( hash_articulo['Language'].blank? ? 'sin información' : hash_articulo['Language'].gsub('\\', '') )
			        idio = Idioma.find_by(idioma: idioma)
			        if idio.blank?
			        	idio = Idioma.create(idioma: idioma)
			        end

			        # REFILL
			        if hash_articulo['Journal'].blank?
			        	rev = Revista.find_by(revista: '')
			        	unless rev.blank?
			        		rev.publicaciones.delete(pub)
			        		rev.delete if rev.publicaciones.empty?
			        	end
			        end 

			        revista = ( hash_articulo['Journal'].blank? ? hash_articulo['Publisher'].gsub('\\', '') : hash_articulo['Journal'].gsub('\\', '') )
			        revista = 'sin información' if revista.blank?
			        rev = Revista.find_by(revista: revista)
			        if rev.blank?
			        	rev = Revista.create(revista: revista, idioma_id: idio.id)
			        end
			        rev.publicaciones << pub
		    	end

		    	# origen = 'carga'
	        	pub.origen = 'carga' if ['remplazar_carga', 'remplazar_doi', 'nuevo', 'colision_titulo'].include?(unicidad)
	        	pub.save if ['remplazar_carga', 'remplazar_doi', 'nuevo', 'colision_titulo'].include?(unicidad)

	        	unless unicidad == 'saltar'
	        	unless pub.proyectos.ids.include?(proyecto_activo.id)
	        		pub.proyectos << proyecto_activo
	        	end
	        	end

	        	# procesa AUTORES
	        	if ['remplazar_doi', 'nuevo', 'colision_titulo'].include?(unicidad)
					p_autores = pub.author.gsub(/\r/," ").gsub(/\n/," ").split(' and ')
					p_autores.each do |aut|
						i = Investigador.find_by(investigador: aut.strip)
						if i.blank?
						  i = Investigador.create(investigador: aut.strip)
						end
		  	         	pub.investigadores << i
					end

				end

				## CARPETAS {'Carga', 'Ingreso', 'Duplicados', 'Revisar', 'Excluidas', 'Postergadas', 'Revisadas'}
				cpt = (unicidad == 'colision_titulo' ? proyecto_activo.carpetas.find_by(carpeta: 'Duplicados') : proyecto_activo.carpetas.find_by(carpeta: 'Carga'))

	        	# Uso la condicion que que no este en las carpetas del Investigador hay que cubrir
	        	# 1. Publicacion ya revisada por mi puesta en una carpeta distinta a REVISA
	        	# 2. Publicacion existente ingresada por otro usuario fuera de mis carpetas
#	        	activo = Perfil.find(session[:perfil_activo]['id'])
	        	unless unicidad == 'saltar'
					if pub.carpetas.empty? or pub.carpetas.ids.intersection(proyecto_activo.carpetas.ids).empty?
						pub.cargas << carga unless pub.cargas.ids.include?(carga)
						pub.carpetas << cpt unless pub.carpetas.ids.include?(cpt.id)
					end
				end

				n_nuevos     += 1 if unicidad == 'nuevo'
				n_duplicados += 1 if unicidad == 'colision_titulo'
				n_vinculados += 1 if unicidad == 'remplazar_carga'
				n_existentes += 1 if unicidad == 'saltar'

		    end
		    carga.n_procesados = n_procesados
		    carga.n_nuevos     = n_nuevos
		    carga.n_duplicados = n_duplicados
		    carga.n_vinculados = n_vinculados
		    carga.n_existentes = n_existentes
			carga.estado = 'procesada'
			carga.save
		end
	end

	def procesa_archivo_bib(archivo)
		estado   = 'inicio'
		n_llave  = 0
		registro = Hash.new
		clave    = ''
		valor    = ''
		elementos = []

		archivo.each_char do |c|
			case estado
			when 'inicio'	#Esperando un '@'
				case c
				when '@'
					clave = 'eda_type_id'
					valor = '@'
					estado = 'eda_type_id'
				end
			when 'eda_type_id'	# en medio de 'eda_type_id'
				case c
				when '{'
					registro.store(clave.strip, valor.strip)
					clave = 'eda_id'
					valor = ''
					n_llave += 1
					estado = 'eda_id'
				else
					valor += c
				end
			when 'eda_id'	# en medio de 'eda_id'
				case c
				when ','
					registro.store(clave.strip, valor.strip)
					clave = ''
					valor = ''
					estado = 'clave'
				else
					valor += c
				end
			when 'clave'	# leyendo la 'clave'
				case c
				when '='
					estado = 'valor'
				when '}'	# Es difícil que en mediode una clave aparezca '}', sólo si es el primer caracter y muestra fin de registro
					elementos << registro
					registro = Hash.new
					estado = 'inicio'
				else
					clave += c
				end
			when 'valor'	# Esperando un '{' que anuncia el valor o el primer nivel del valor
				case c
				when '{'
					n_llave = 0
					slash = false
					estado = 'nivel 1'
				end
			when 'nivel 1'
				if slash
					slash = false
					valor += (c == 'n' ? '\n' : c)
				else
					case c
					when '{'
						n_llave += 1
					when '}'
						if n_llave == 0
							registro.store(clave.strip, valor.strip)
							clave = ''
							valor = ''
							estado = 'cierre campo'
						else
							n_llave -= 1
						end
					when '\\'
						slash = true
					else
						valor += c
					end
				end
			when 'cierre campo'
				case c
				when ','
					estado = 'clave'
				end
			end
		end
		elementos
	end

	# applecation_controller.rb | carga_arechivo_bib (arriba)
	# VERIFICA CARGA
	# 1. Verifica que ya haya sido cargada
	# 2. Si ya ha sido cargada, puede ser una versión más completa
	# VERIFICA INGRESOS
	# 1. Verifica por DOI
	# 2. Verifica por Nombre de la publicación
	def unicidad_publicacion_carga(hash_articulo)
		publicacion = Publicacion.find_by(unique_id: hash_articulo['Unique-ID']) 
		if publicacion.blank?
			# NO ENCONTRADO EN CARGA buscamos por DOI
			i = Publicacion.find_by(doi: hash_articulo['DOI'])
			if i.blank? or hash_articulo['DOI'].blank?
				# NO LO ENCONTRO POR DOI -> Preguntar por TITULO
				t = Publicacion.find_by(title: hash_articulo['Title'])
				t.blank? ? 'nuevo' : 'colision_titulo'
			else
				# LO ENCONTRO POR DOI
				'remplazar_doi'
			end
		else
			proyecto_activo = Proyecto.find(session[:proyecto_activo]['id'])
			if publicacion.carpetas.ids.intersection(proyecto_activo.carpetas.ids).empty?
				'sin carpeta'
			else
				!!publicacion.doc_type.match(/Early Access/) ? 'remplazar_carga' : 'saltar'   
			end
		end
	end

	# publicaciones_controller.rb
	## IDENTICO A UNO EN CVCH
	# este método procesa Autores, Investigadores y Revistas de una publicación
	def procesa_ingreso(objeto)

		# Procesa Autores
		authors = []
		last_author = objeto.author.split('&').last
		prev_authors = objeto.author.split('&')[0].split(',')
		prev_authors.each_with_index  do |val, index|
			# Encontramos un caso donde sólo se usa el apellido
			if val.split(' ').length == 1
				author_with_format = val.strip
			else
				author_with_format = (index == 0 ? (val.split(' ')[1]+' '+val.split(' ')[0]) : val.strip)
			end
			authors << author_with_format
		end
		authors << last_author unless last_author == objeto.author

		authors.each do |aut|
			inv = Investigador.find_by(investigador: aut)
			if inv.blank?
				inv = Investigador.create(investigador: aut)
			end
			objeto.investigadores << inv unless objeto.investigadores.ids.include?(inv.id)
		end

		# Procesa Revista
		# Se usa 'd_journal' porque en Publicacion sólo se usa revista_id
		rev = Revista.find_by(revista: objeto.journal)
		if rev.blank?
			rev = Revista.create(revista: objeto.journal)
		end
		rev.publicaciones << objeto
	
	end

	def campo_sin_nr(campo)
		campo.gsub(/\r/," ").gsub(/\n/," ")
	end

	def lista_blanca_campo(campo)
		base = campo_sin_nr(campo)
		limpio = ''
		base.strip.split('').each do |c|
			if !!c.match(/[a-zA-ZáéíóúàèìòùäëïöüñÁÉÍÓÚÀÈÌÒÙÄËÏÖÜÑ\.;\-,&\s]/)
				limpio += c
			end
		end
		limpio.strip
	end

	# publicaciones_controller.rb
	## IDENTICO A UNO EN CVCH
	# Limpia el autor de elementos que no deben estar en el campo
	def limpia_autor_ingreso(autor)
		# Limpia el autor sacando los catacteres que no están
		limpio = lista_blanca_campo(autor)

		autor_con_coma = limpio.split(';').join(',').split(' and ').join(',').split('&').join(',')

		# NO sacamos los puntos porque la idea en EDA no es construir un formato, sino guardar los datos.
		# Los puntos pueden ser útiles para discriminar los campos.
#		elementos = autor_con_coma.split(',').map {|cc| cc.split('.').join('').strip}
		elementos = autor_con_coma.split(',')

		autores = []
		# SACA LOS ELEMENTOS QUE SON CARACTERES O VACIOS
		elementos.each do |a|
			# NO considera Autores que tengan un sólo elemento
			unless a.strip.split(' ').length < 2
				partes = a.strip.split(' ')
				# Si la última palabra es un único caracter
				if partes.last.length == 1
					#lo saca
					partes.pop
					autores << partes.join(' ')
				else
					autores << a
				end
			end
		end
		# LE DA FORMARTO AL CAMPO AUTORES
		last = autores.last
		autores.pop
		case autores.length
		when 0
			last
		when 1
			autores[0]+' & '+last
		else
			autores.join(', ')+' & '+last
		end
	end

	def proceso_d_journal(d_journal)
		match_year = d_journal.strip.match(/(?<anterior>[^\(]*) \((?<year>\d{4})\) (?<siguiente>.*)/)
		anterior = match_year[:anterior].strip
		siguiente = match_year[:siguiente].strip

		resultado = {}

		if !!anterior.match(/\d+/)
			# la revista tienen el volumen
			match_journal_volume = anterior.strip.match(/(?<journal>\D*) (?<volume>\d*)/)

			resultado[:journal] = match_journal_volume[:journal].strip
			resultado[:volume] = match_journal_volume[:volume].strip
			resultado[:pages] = siguiente
		else
			resultado[:journal] = anterior

			if siguiente.split(':').length == 2
				resultado[:volume] = siguiente.split(':')[0].strip
				resultado[:pages] = siguiente.split(':')[1].strip
			elsif siguiente.split(',').length == 2
				resultado[:volume] = siguiente.split(',')[0].strip
				resultado[:pages] = siguiente.split(',')[1].strip
			else
				resultado[:volume] = ''
				resultado[:pages] = siguiente
			end
		end
		resultado[:year] = match_year[:year]

		resultado
	end

	def procesa_d_doi(d_doi)
        primer_filtro_doi = d_doi.strip.delete_prefix('DOI').delete_prefix('doi:').strip
        (!!primer_filtro_doi.match(/doi.org/) ? primer_filtro_doi.strip.split('doi.org/')[1] : primer_filtro_doi)
	end
end