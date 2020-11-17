class ApplicationController < ActionController::Base
	def carga_archivo_bib(carga)
	    @file = File.open(carga.archivo)
	    # Lee el archivo
	    @file_data = @file.read
	    # Obtiene un arreglo de 'articulos'
	    @articles = @file_data.split('@article')
	    @articles.shift # elimina el primer elemento vacio
	    # los procesa
	    @articles.each do |articulo|
	      # primero cargamos el Hash, para tener qeu comparar
	      hash_articulo = ApplicationController::helpers.articulo_bib(articulo)
	      # lo carga SOLO si no existe ya
	      if Publicacion.find_by(unique_id: hash_articulo['Unique-ID']).blank?
	        p = Publicacion.new
	        Publicacion::NOMBRES_BIB.each do |bib|
	          p.write_attribute(bib.downcase.split('-').join('_'), hash_articulo[bib])
	        end

	        # Agrega IDIOMA -> REVISTA
	        idio = Idioma.find_by(idioma: hash_articulo['Language'])
	        if idio.blank?
	          idio = Idioma.create(idioma: hash_articulo['Language'])
	        end

	        rev = Revista.find_by(revista: hash_articulo['Journal'])
	        if rev.blank?
	          rev = Revista.create(revista: hash_articulo['Journal'], idioma_id: idio.id)
	        end
	        p.revista_id = rev.id

	        # Guarda la publicacion!
	        p.save

	        # Agregar Relación de Carga
	        p.cargas << carga

	      end
	    end
	end

	def procesa_autores_publicaciones(coleccion)
	    coleccion.each do |pub|
	      # PROCESA AUTORES
	      p_autores = pub.author.split(' and ')
	      p_autores.each do |aut|
	        i = Investigador.find_by(investigador: aut)
	        if i.blank?
	          i = Investigador.create(investigador: aut)
	        end
	        aa = Autor.find_by(publicacion_id: pub.id, investigador_id: i.id)
	        if aa.blank?
	        	Autor.create(publicacion_id: pub.id, investigador_id: i.id)
	        end
	      end
	    end
	end
end
