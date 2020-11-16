class ApplicationController < ActionController::Base
	def carga_archivo_bib(archivo_bib)
	    @file = File.open(archivo_bib)
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
	        p = Publicacion.new(carga_id: @objeto.id)
	        Publicacion::NOMBRES_BIB.each do |bib|
	          p.write_attribute(bib.downcase.split('-').join('_'), hash_articulo[bib])
	        end
	        # Guarda la publicacion!
	        p.save
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

	def procesa_kewwords_publicaciones(coleccion)
	    coleccion.each do |pp|
	      # PROCESA CLAVES
	      keys =  pp.keywords.blank?                  ? [] : pp.keywords.split('; ')
	      keys += pp.keywords_plus.blank?             ? [] : pp.keywords_plus.split('; ')
	#      keys += p.research_areas.blank?            ? [] :p.research_areas.split('; ')
	#      keys += p.web_of_science_categories.blank? ? [] :p.web_of_science_categories.split('; ')
	      keys = keys.uniq.map {|key| key.downcase.capitalize}
	      keys.each do |k|
	        c = Concepto.find_by(concepto: k)
	        if c.blank?
	          c = Concepto.create(concepto: k)
	        end
	        rr = Referencia.find_by(publicacion_id: pp.id, concepto_id: c.id)
			if rr.blank?
		        Referencia.create(publicacion_id: pp.id, concepto_id: c.id)
	    	end
	      end
	  	end
	end
end
