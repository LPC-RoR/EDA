module RecursosHelper
	## ------------------------------------------------------- TABLA | BTNS

	def crud_conditions(objeto)
		case objeto.class.name
		when 'Carga'
			objeto.estado == 'ingreso'
		when 'Publicacion'
			objeto.origen == 'ingreso'
		when 'Carpeta'
			not Carpeta::NOT_MODIFY.include?(objeto.carpeta) and controller_name == 'publicaciones' and action_name == 'index'
		when 'Texto'
			false
		when 'Clasificacion'
			false
		when 'Tema'
			controller_name == 'publicaciones'
		when Proyecto
			controller_name == 'proyectos'
		when 'Tabla'
			objeto.archivo.blank?
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
