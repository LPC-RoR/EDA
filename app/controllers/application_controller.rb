class ApplicationController < ActionController::Base
	## USO GENERAL
	# Este método se usa para construir un nombre de directorio a partir de un correo electrónico.
	def archivo_usuario(email)
		email.split('@').join('-').split('.').join('_')
	end

	def inicia_sesion
		if usuario_signed_in?
		  # Perro furioso
		  @dog = Administrador.find_by(email: 'hugo.chinga.g@gmail.com')
		  @dog = Administrador.create(administrador: 'Hugo Chinga G.', email: 'hugo.chinga.g@gmail.com') if @dog.blank?

		  # En este minuto SIMULA que viene de la autenticacion con un usuario.email == 'hugo.chinga.g@gmail.com'
		  # 1.- Verifica si Hay Perfil para ese correo
		  @perfil = Perfil.find_by(email: current_usuario.email)
		  @perfil = Perfil.create(email: current_usuario.email) if @perfil.blank?

		  # 2.- Preguntamos SI ESTA EN LA LISTA DE ADMINISTRADORES, si ESTÁ se asegura de relacionarlo
		  @administrador = Administrador.find_by(email: @perfil.email)
		  # ACTUALIZO ADMINISTRADOR DEL PERFIL SI ES NECESARIO
		  if @administrador.present? and @perfil.administrador.blank?
		    @perfil.administrador = @administrador
		    @perfil.save
		  end

		  if @perfil.carpetas.empty?
		    @perfil.carpetas.create(carpeta: 'Carga')
		    @perfil.carpetas.create(carpeta: 'Ingreso')
		    @perfil.carpetas.create(carpeta: 'Duplicados')
		    @perfil.carpetas.create(carpeta: 'Revisar')
		    @perfil.carpetas.create(carpeta: 'Excluidas')
		    @perfil.carpetas.create(carpeta: 'Postergadas')
		    @perfil.carpetas.create(carpeta: 'Revisadas')
		  end

		  session[:perfil_base]      = @perfil
		  session[:perfil_activo]    = @perfil
		  session[:administrador]    = @perfil.administrador
		  session[:es_administrador] = @perfil.administrador.present?
		end
	end

	# cargas_controller.rb
	def carga_archivo_bib(carga)

		if carga.estado == 'ingreso'

			## ABRE ARCHIVO
	 	    @file = File.open("#{Rails.root}/public/#{carga.archivo_carga.url}")
		    # Lee el archivo
		    @file_data = @file.read
		    # Obtiene un arreglo de 'articulos'
		    @articles = @file_data.split('@article')
		    @articles.shift # elimina el primer elemento vacio
		    # los procesa
		    n_procesados = 0 # TOTAL de artículos procesados
		    n_nuevos     = 0 # Publicaciones NUEVAS que se integraron a la colección de publicaciones
		    n_duplicados = 0 # Criterio DUPLICADOS ('titulo'), revisar con CVCH
		    n_vinculados = 0 # Publicaciones de OTRO USUARIO que se VINCULO a la colección del USUARIO
		    n_existentes = 0 # Publicaciones REPETIDAS. NO se consideraron
		    @contador = 0
		    @articles.each do |articulo|
		    	n_procesados += 1
		    	@contador += 1

		    	## PROCESA HASH PUBLICACION
		    	# primero cargamos el Hash, para tener que comparar
		    	hash_articulo = articulo_bib(articulo)

		    	## UNICIDAD
		    	# Luego evaluamos la unicidad del árticulo {}
		    	unicidad = unicidad_publicacion_carga(hash_articulo)

		    	case unicidad
		    	when 'remplazar_carga'
		    		# Se recupera la publicación INCOMPLETA de la colección para completar la información
		      		pub = Publicacion.find_by(unique_id: hash_articulo['Unique-ID'])
		    	when 'remplazar_doi'
		    		# Se recupera la publicación con DOI para privilegiar el formato WOS
		      		pub = Publicacion.find_by(doi: hash_articulo['DOI'])
		    	when 'nuevo'
		    		# Completamente nueva
		      		pub = Publicacion.new
		    	when 'colision_titulo'
		      		# se creará el duplicado para resolver la duplicidad en la aplicación
		      		pub = Publicacion.new
				when 'sin carpeta'
			  		# Publicacion de otro usuario
			      	pub = Publicacion.find_by(unique_id: hash_articulo['Unique-ID'])
		    	end

		    	# llenado desde hash para los registros vacíos o por corregir
		    	if ['remplazar_carga', 'remplazar_doi', 'nuevo', 'colision_titulo'].include?(unicidad)
			        Publicacion::NOMBRES_BIB.each do |bib|
			        	if bib == 'Type'
				        	pub.write_attribute('doc_type', hash_articulo[bib])
			        	else
				        	pub.write_attribute(bib.downcase.split('-').join('_'), hash_articulo[bib])
			        	end
			        end
			        pub.origen = 'WOS_bib'
			        pub.t_sha1 = Digest::SHA1.hexdigest(pub.title)
		    	end

		    	# BORRAR REVISTA Y AUTORES
		    	# Los ingresos manuales no llenan el IDIOMA
		    	if unicidad == 'remplazar_doi'
			      	if pub.revista.publicaciones.count == 1
			      		r = pub.revista
			      		r.publicaciones.delete(pub)
			      		r.delete
			      	end

			      	pub.investigadores.each do |i|
			      		if i.publicaciones.count == 1
			      			pub.investigadores.delete(i)
			      			i.delete
			      		else
			      			pub.investigadores.delete(i)
			      		end
			      	end
		    	end

		    	# LLENAR IDIOMA REVISTA
		    	if ['remplazar_doi', 'nuevo', 'colision_titulo'].include?(unicidad)
			        # Agrega IDIOMA -> REVISTA
			        idio = Idioma.find_by(idioma: hash_articulo['Language'])
			        if idio.blank?
			        	idio = Idioma.create(idioma: hash_articulo['Language'])
			        end

			        rev = Revista.find_by(revista: hash_articulo['Journal'])
			        if rev.blank?
			        	rev = Revista.create(revista: hash_articulo['Journal'], idioma_id: idio.id)
			        end
			        rev.publicaciones << pub
		    	end

		    	# saca las comas de los autores
		    	pub.author = pub.author.split(' and ').map {|aut| aut.split(',').join('')}.join(' and ')

		    	# origen = 'carga'
	        	pub.origen = 'carga' if ['remplazar_doi', 'nuevo', 'colision_titulo'].include?(unicidad)
	        	pub.save if ['remplazar_carga', 'remplazar_doi', 'nuevo', 'colision_titulo'].include?(unicidad)

	        	# procesa AUTORES
	        	if ['remplazar_doi', 'nuevo', 'colision_titulo'].include?(unicidad)
					p_autores = pub.author.split(' and ')
					p_autores.each do |aut|
						i = Investigador.find_by(investigador: aut.strip)
						if i.blank?
						  i = Investigador.create(investigador: aut.strip)
						end
		  	         	pub.investigadores << i
					end

				end

				## CARPETAS {'Carga', 'Ingreso', 'Duplicados', 'Revisar', 'Excluidas', 'Postergadas', 'Revisadas'}
				cpt = (unicidad == 'colision_titulo' ? Carpeta.find_by(carpeta: 'Duplicados') : Carpeta.find_by(carpeta: 'Carga'))

	        	# Uso la condicion que que no este en las carpetas del Investigador hay que cubrir
	        	# 1. Publicacion ya revisada por mi puesta en una carpeta distinta a REVISA
	        	# 2. Publicacion existente ingresada por otro usuario fuera de mis carpetas
	        	activo = Perfil.find(session[:perfil_activo]['id'])
				unless pub.carpetas.ids.intersection(activo.carpetas.ids).any?
					pub.cargas << carga 
					pub.carpetas << cpt
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

	# applecation_controller.rb | carga_arechivo_bib (arriba)
	# VERIFICA CARGA
	# 1. Verifica que ya haya sido cargada
	# 2. Si ya ha sido cargada, puede ser una versión más completa
	# VERIFICA INGRESOS
	# 1. Verifica por DOI
	# 2. Verifica por Nombre de la publicación
	def unicidad_publicacion_carga(hash_articulo)
		# VERIFICA CARGA
		c = Publicacion.find_by(unique_id: hash_articulo['Unique-ID']) 
		if c.blank?
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
			# LO ENCONTRÖ HAY QUE VER SI ESTÁ EN ALGUNA DE MIS CARPETAS
			activo = Perfil.find(session[:perfil_activo]['id'])
			if c.carpetas.ids.intersection(activo.carpetas.ids).empty?
				'sin carpeta'
			else
				c.year.blank? ? 'remplazar_carga' : 'saltar'
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

	# publicaciones_controller.rb
	## IDENTICO A UNO EN CVCH
	# Limpia el autor de elementos que no deben estar en el campo
	def limpia_autor_ingreso(autor)
		# Limpia el autor sacando los catacteres que no están
		autor_limpio = ''
		autor.strip.split('').each do |c|
			if !!c.match(/[a-zA-ZáéíóúàèìòùäëïöüñÁÉÍÓÚÀÈÌÒÙÄËÏÖÜÑ\.;\-,&\s]/)
				autor_limpio += c
			end
		end
		autor_limpio = autor_limpio.strip

		autor_con_coma = autor_limpio.split(';').join(',').split(' and ').join(',').split('&').join(',')

		elementos = autor_con_coma.split(',').map {|cc| cc.split('.').join('').strip}

		autores = []
		# SACA LOS ELEMENTOS QUE SON CARACTERES O VACIOS
		elementos.each do |a|
			unless a.strip.split(' ').length < 2
				partes = a.strip.split(' ')
				if partes.last.length == 1
					partes.pop
					autores << partes.join(' ')
				else
					autores << a
				end
			end
		end

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

	# application_controller.rb | carga_archivo_bib (arriba)
	# PROCESA ARTICULO :BIB DE WEB OF SCIENCE (CARGA)
	def articulo_bib(bib_article)
		st = 0
		resultado = Hash.new
		llave = ''
		valor = ''
		palabra = ''

		# para el manejo de niveles adicionales
		origen = 0
		nivel = 0
#		bib_article.strip.split('').each do |c|
		bib_article.strip.each_char do |c|
			break if st == 100
			palabra += c
			case st
			when 0 # INICIO
				if c.match(/'s/) # elimina espacios (por seguridad)
				elsif c.match(/\{/) # inicio articulo
					st = 1
				else # FATAL
					st = 100
				end
			when 1 # INICIO ARTICULO
				if c.match(/\s/) # elimina espacios
				elsif c.match(/I/) # inicio ISI_ID
					st = 2
				else # FATAL
					st = 100
				end
			when 2 # INICIO ISI_ID
				if c.match(/[IS:0-9]/) # consume ISI_ID
					# no guarda el código porque aparece más adelante
				elsif c.match(/,/) # fin ISI_ID
					st = 3
				else # FATAL
					st = 100
				end
			when 3 # NOMBRE
				if c.match(/[\s\n]/) # elimina espacios y cambios de línea
				elsif c.match(/[a-zA-Z]/) # inicio campo
					llave += c
					st = 4
				else # FATAL
					st = 100
				end
			when 4 # LLAVE
				if c.match(/[a-zA-Z0-9\-\s]/) # inicio Inicial/Apellido? CAMBIAR LO DE ABAJO!
					llave += c
				elsif c.match(/=/) # =
					st = 5
				else # FATAL
					st = 100
				end
			when 5 # =
				if c.match(/[\s]/) # elimina espacios
				elsif c.match(/\{/) # 1er NIVEL
					st = 6
				else # FATAL
					st = 100
				end
			when 6 # . 1er NIVEL
				if c.match(/\{/) # 2do NIVEL
					st = 10
				elsif c.match(/\S/) # Inicial
					valor += c
					st = 7
				else # FATAL
					st = 100
				end
			when 7 # VALOR + control de niveles adicionales de {}
				if c.match(/[\n\\]/) # . Inicial
#					valor += ' '
				elsif c.match(/\{/) # . APERTURA nivel adicional
					valor += c
					origen = 7
					nivel = 1
					st = 50
				elsif c.match(/[^\}]/) # . Inicial
					valor += c
				elsif c.match(/\}/) # fin Inicial
					st = 8
				else # FATAL
					st = 100
				end
			when 8 # FIN 1er NIVEL
				if c.match(/[\s\n]/) # fin campo
				elsif c.match(/,/) # consume espacios
					resultado.store(llave.strip, valor.strip.split(' ').join(' '))
					llave = ''
					valor = ''
					st = 9
				else # FATAL
					st = 100
				end
			when 9 # FIN 1er NIVEL
				if c.match(/[\s\n]/) # consume espacios y cambios de linea
				elsif c.match(/\}/) # fin articulo
					st = 20
					break
				elsif c.match(/[a-zA-Z]/) # consume espacios
					llave += c
					st = 4
				else # FATAL
					st = 100
				end
			when 10 # VALOR
				if c.match(/[^\}]/) # completa apellido
					valor += c
					st = 11
				else # FATAL
					st = 100
				end
			when 11 # VALOR
				if c.match(/[\n\\]/) # 
				elsif c.match(/\{/) # . APERTURA nivel adicional
					valor += c
					origen = 11
					nivel = 1
					st = 50
				elsif c.match(/[^\}]/) # completa valor
					valor += c
				elsif c.match(/\}/) # primer cierre
					st = 12
				else # FATAL
					st = 100
				end
			when 12 # 1er CIERRE LLAVE
					#palabra += 'paso por 12 '+c
				if c.match(/\}/) # segundo cierre
					st = 8
				else # FATAL
					st = 100
				end
			when 50
				if c.match(/[\n\\]/) # 
				elsif c.match(/\{/) # . APERTURA nivel adicional
					valor += c
					nivel += 1
				elsif c.match(/[^\}]/) # completa valor
					valor += c
				elsif c.match(/\}/) # primer cierre
					nivel -=1
					st = origen if nivel == 0 # se pone antes!
				else # FATAL
					st = 100
				end
			end
		end
		resultado
	end
end
