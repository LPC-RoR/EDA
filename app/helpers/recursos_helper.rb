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
	        ["Proyecto Activo", "/proyectos/proyecto_activo", 'usuario'],
	        ["Proyectos",       "/proyectos",                 'usuario'],
#	        ["Carpetas",        "/carpetas",        'usuario'],
#	        ["Temas",           "/temas",                     'usuario'],
#	        ["Textos",          "/textos",                    'usuario'],
	        ['Datos',           '/datos',                     'usuario'],
	        ["Cargas",          "/cargas",                    'usuario'],
	        ["Administradores", "/administradores",             'admin'],
	        ["Temas Ayuda",     "/tema_ayudas",                 'admin'] 
	    ]
	end

	def display_item_app(item, tipo_item)
		session[:hay_proyecto] or ['Proyectos', 'Temas'].include?(item)
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

	def crud_conditions(objeto)
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
		when Proyecto
			controller_name == 'proyectos'
		when 'Tabla'
			controller_name == 'datos'
		when 'Perfil'
			false
		end
	end

	def x_conditions(objeto, btn)
		case objeto.class.name
		when 'Carga'
			objeto.estado == 'ingreso'
		when 'Texto'
			controller_name == 'publicaciones'
		when 'Carpeta'
			controller_name == 'publicaciones' and (not Carpeta::NOT_MODIFY.include?(objeto.carpeta)) and action_name == 'show'
		when 'Clasificacion'
			objeto.clasificacion != btn
		when 'Tema'
			controller_name == 'proyectos' and objeto.perfil.id == session[:perfil_activo]['id'].to_i
		when 'Tabla'
			objeto.archivo.present? and objeto.encabezados.empty?
		when 'Proyecto'
			objeto.activo.blank? or objeto.activo == false
		when 'Perfil'
			controller_name == 'proyectos'
		end
	end

	## ------------------------------------------------------- FORM & SHOW

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
