module RecursosHelper
	## ------------------------------------------------------- MENU

    ## Menu principal de la aplicación
    # [0] : Item del menú
    # [1] : Link del ítem
    # [2] : Tipo de ítem {'admin', 'usuario', 'anonimo', 'excluir'}
    # se usa directamente en 0p/navbar/_navbar.html.erb
	def menu
	    [
	        ["Publicaciones",   "/publicaciones",             'usuario'],
	        ["Ingresos",        "/ingresos",                  'usuario'],
	        ["Proyectos",       "/proyectos",                 'usuario'],
#	        ["Carpetas",        "/carpetas",        'usuario'],
	        ["Temas",           "/temas",                     'usuario'],
	        ["Bibliografía",    "/recursos/bibliografia",     'usuario'],
	        ['Datos',           '/datos',                     'usuario'],
	        ["Cargas",          "/cargas",                    'usuario'],
	        ["Administradores", "/administradores",             'admin'],
	        ["Temas Ayuda",     "/tema_ayudas",                 'admin'],
	        ["Procesos",        "/recursos/procesos",             'dog']
	    ]
	end

	def display_item_app(item, tipo_item)
		case item
		when 'Temas'
			session[:hay_proyecto] and Proyecto.find(session[:proyecto_activo]['id']).carpetas_personalizadas.any?
		else
			session[:hay_proyecto] or ['Proyectos'].include?(item)
		end
	end

	## ------------------------------------------------------- TABLA | BTNS

	def tr_row(objeto)
		case objeto.class.name
		when 'Publicacion'
			if usuario_signed_in?
				'default'
			else
				'default'
			end
		else
			'default'
		end
	end

	def crud_conditions(objeto, btn)
		case objeto.class.name
		when 'Carga'
			objeto.estado == 'ingreso'
		when 'Publicacion'
			objeto.origen == 'ingreso'
		when 'Carpeta'
			not Carpeta::NOT_MODIFY.include?(objeto.carpeta) and controller_name == 'proyectos'
		when 'Texto'
			false
		when 'Clasificacion'
			false
		when 'Tema'
			['publicaciones', 'temas'].include?(controller_name)
		when 'Proyecto'
			controller_name == 'proyectos'
		when 'Tabla'
			controller_name == 'datos'
		when 'Perfil'
			false
		else
			true
		end
	end

	def x_conditions(objeto, btn)
		case objeto.class.name
		when 'Carpeta'
			case btn
			when 'Desasignar'
				controller_name == 'publicaciones' and (not Carpeta::NOT_MODIFY.include?(objeto.carpeta)) and action_name == 'show' and @coleccion['carpetas'].count > 1
			when 'Eliminar'
				controller_name == 'publicaciones' and (not Carpeta::NOT_MODIFY.include?(objeto.carpeta)) and action_name == 'show' and objeto.temas.empty? and @coleccion['carpetas'].count > 1
			end
		when 'Carga'
			objeto.estado == 'ingreso'
		when 'Texto'
			controller_name == 'publicaciones'
		when 'Clasificacion'
			objeto.clasificacion != btn
		when 'Tema'
			case btn
			when 'Desasignar'
				controller_name == 'temas'
			when 'Eliminar'
				controller_name == 'temas' and objeto.textos.empty?
			end
		when 'Proyecto'
			objeto.activo.blank? or objeto.activo == false
		when 'Perfil'
			controller_name == 'proyectos'
		when 'Tabla'
			objeto.archivo.present? and objeto.encabezados.empty?
		else
			true
		end
	end

	def x_btns(objeto)
		case objeto.class.name
		when 'Carpeta'
			[
				['Desasignar', '/desasigna_carpeta', true],
				['Eliminar', '/elimina_carpeta', true]
			]
		when 'Carga'
			[['Proceso', '/procesa_carga', false]]
		when 'Texto'
			[['Desasignar', '/desasignar', true]]
		when 'Clasificacion'
			[
                ['referencia',     '/clasifica?clasificacion=referencia'    , true],
                ['complementario', '/clasifica?clasificacion=complementario', true],
                ['controversial',  '/clasifica?clasificacion=controversial' , true],
                ['revisar',        '/clasifica?clasificacion=revisar'       , true]
            ]
        when 'Tema'
        	[
#        		['Desasignar', '/desasignar', true],
        		['Eliminar', '/eliminar', true]
        	]
        when 'Proyecto'
        	[['Activo', '/activo', false]]
        when 'Perfil'
        	[['Desvincular', '/desvincular', true]]
        when 'Tabla'
        	[['Cargar', '/cargar_tabla', true]]
        else
        	[]
		end		
	end

	def show_link_condition(objeto)
		case objeto.class.name
		when 'Proyecto'
			objeto.id == session[:proyecto_activo]['id']
		else
			true
		end
	end

	## ------------------------------------------------------- FORM & SHOW

	def detail_controller_path(controller)
#		if ['documento_bases'].include?(controller)
#			"documento/#{controller}/detail"
#		elsif ['asignatura_bases', 'asignatura_nivel_bases'].include?(controller_name)
#			"estructura/#{controller}/detail"
#		else
			"#{controller}/detail"
#		end
	end

	# apoyo de filtro_condicional_field? (abajo)
	def get_field_condition(objeto, field)
		case objeto.class.name
		when 'Publicacion'
			objeto.origen == 'ingreso'
		when 'Mensaje'
			field != 'email' or not usuario_signed_in?
		end
	end

	## ------------------------------------------------------- SHOW

	# Método de apoyo usado en get_new_link (abajo)
	def objeto_title(objeto)
		case objeto.class.name
		when 'Publicacion'
			objeto.title
		when 'Linea'
			objeto.columnas.order(:orden).first.columna
		end
	end

	def show_links(objeto)
		case objeto.class.name
		when 'Publicacion'
			[
				['Editar',     [:edit, objeto], objeto.origen == 'ingreso'],
				['Papelera',   "/publicaciones/estado?publicacion_id=#{objeto.id}&estado=papelera",     (['ingreso', 'duplicado'].include?(objeto.estado) and objeto.origen = 'ingreso')],
				['Eliminar',   "/publicaciones/estado?publicacion_id=#{objeto.id}&estado=eliminado",    ['papelera'].include?(objeto.estado)],
				['Publicar',   "/publicaciones/estado?publicacion_id=#{objeto.id}&estado=publicada",    (['ingreso'].include?(objeto.estado) and objeto.title.present? and objeto.author.present? and objeto.journal.present?)],	
				['Ingreso',    "/publicaciones/estado?publicacion_id=#{objeto.id}&estado=ingreso",      (['publicado', 'papelera'].include?(objeto.estado) and objeto.origen == 'ingreso')],
				['Múltiple',   "/publicaciones/estado?publicacion_id=#{objeto.id}&estado=multiple",     objeto.estado == 'duplicado'],
				['Corrección', "/publicaciones/estado?publicacion_id=#{objeto.id}&estado=correccion",   (objeto.estado == 'publicada' and objeto.origen == 'ingreso' and objeto.textos.empty?)]
			]
		end
	end

end
