module ApplicationHelper
	# Obtiene los controladores que no despliegan menu
	def nomenu?(controller)
		Recurso::NOMENU_CONTROLLERS.include?(controller)
	end

	def recursos_tabs(accion)
		Recurso::RECURSO_ACTIONS_TABS[accion]
	end

	# Pregunta si la "accion" del "recursos_controller" despliega TABS
	# "_frame.html.erb"
	def recursos_tabs?(accion)
		Recurso::RECURSO_ACTIONS_TABS.keys.include?(accion)
	end
	def recursos_titulo?(accion)
		Recurso::RECURSO_ACTIONS_TITULO.keys.include?(accion)
	end
	# Pregunta si la "accion" del "recursos_controller" despluega TABLA
	# "_frame.html.erb"
	def recursos_tabla?(accion)
		Recurso::RECURSO_ACTIONS_DISPLAY[accion] == 'tabla'
	end

	def frame_controller?(controller)
		Recurso::FRAME_CONTROLLERS.include?(controller)
	end
	# Obtiene los TABS de un modelo usando el controlador
	def m_tabs(controller)
		controller.classify.constantize::TABS
	end
	# Obtiene los estados de un modelo usando el controlador
	def m_estados(controller)
		controller.classify.constantize::ESTADOS
	end

	# valida el uso de alias en las tablas
	def alias_tabla(controller)
		case controller
		when 'clientes'
			'registros'
		when 'Referencia'
			'publicaciones'
		when 'Produccion'
			'publicaciones'
		else
			controller
		end
	end
	# En un modelo donde "ftab" es el tab del frame, "tab" el del modelo y "estado" el que controla los estados de la tabla
	# este método entrega el link para el manejo de cada tab entregando el controlador y la variable {'ftab', 'tab', 'estado'}
	# HAY UN CASO DONDE SE OCUPEN LAS TRES VARIABLES ??
	def get_link(c, var)
		case var
		when 'ftab'
			"/#{controller_name}/#{action_name}?ftab="
		when 'tab'
			action_name == 'show' ? "/#{controller_name}/#{@objeto.id}?tab=" : "/#{controller_name}?ftab=#{@ftab}&tab="
		when 'estado'
			if action_name == 'show'
				has_many_tabs(controller_name).empty? ? "/#{controller_name}/#{@objeto.id}?estado=" : "/#{controller_name}/#{@objeto.id}?tab=#{@tab}&estado="
			else
				frame_controller?(c) ? "/#{controller_name}/#{action_name}?ftab=#{@ftab}&tab=#{@tab}&estado=" : "/#{controller_name}/#{action_name}?ftab=#{@ftab}&estado="
			end
		end
	end

	# Maneja comportamiento por defecto y excepciones de TABLA
	def d_tabla(c, a, label)
		excepcion = false
		# Pregunta si el Modelo TIENE personalizacion
		if Recurso::EXCEPTIONS_CONTROLLERS.include?(controller_name)
			# Pregunta si LABEL tiene personalizacion
			unless c.classify.constantize::TABLE_EXCEPTIONS[label].blank?
				if c.classify.constantize::TABLE_EXCEPTIONS[label][0] == '*' or c.classify.constantize::TABLE_EXCEPTIONS[label].include?(controller_name)
					excepcion = true
				end
			end
		end 

		case Recurso::D_TABLA[label][0]
		when 'all'
			de = Recurso::D_TABLA[label][1]
		when 'self'
			de = (controller_name == c) ? true : false
		end
		(excepcion ? (not de) : de)
	end

	# Maneja comportamiento por defecto y excepciones de SHOW
	def d_show(objeto, label)
		excepcion = false
		# Pregunta si el Modelo TIENE personalizacion
		if Recurso::EXCEPTIONS_MODELS.include?(objeto.class.name)
			# Pregunta si LABEL tiene personalizacion
			excepcion = objeto.class::SHOW_EXCEPTIONS.include?(label)
		end 

		de = Recurso::D_SHOW[label]
		(excepcion ? (not de) : de)
	end

	# Obtiene los campos a desplegar en la tabla desde el objeto
	def m_tabla_fields(objeto)
		objeto.class::TABLA_FIELDS
	end
	def d_rut(rut)
		rut_base = rut.tr('.-', '').length == 8 ? '0'+rut.tr('.-', '') : rut.tr('.-', '')
		rut_base.reverse.insert(1, '-').insert(5, '.').insert(9, '.').reverse
	end
	def d_tel(numero)
		numero.reverse.insert(4, ' ').insert(9, ' ').reverse
	end


	# Toma las relaciones has_many y les descuenta las HIDDEN_CHILDS
	def has_many_tabs(controller)
		controller.classify.constantize.reflect_on_all_associations(:has_many).map {|a| a.name.to_s} - hidden_childs(controller)
	end

	def hidden_childs(controller)
		Recurso::HIDDEN_CHILDS_CONTROLLERS.include?(controller) ? controller.classify.constantize::HIDDEN_CHILDS : []
	end

	def has_child?(objeto)
		# Considera TODO, hasta los has_many through
		objeto.class.reflect_on_all_associations(:has_many).map { |a| objeto.send(a.name).any? }.include?(true)
	end

	def get_new_link(controller)
		case controller.classify.constantize::TIPO_NEW
		# TIPO_NEW = 'new'
		# {'clientes', 'roles'}
		when 'new'
			"/#{controller}/new"
		when 'mask'
			"/#{controller}/mask_new"
		# TIPO_NEW = 'child_new' : show_padre + controller/new
		# {'categorias', 'zonas'}
		when 'child_new'
			"/#{@objeto.class.name.tableize}/#{@objeto.id}/#{controller}/new"
		# TIPO_NEW = 'child_nuevo'
		# {'pedidos'}
		when 'child_nuevo'
			"/#{controller}/nuevo?#{@objeto.class.name.downcase}_id=#{@objeto.id}"
		# TIPO_NEW = 'child_sel' : seleccion ? parametro_padre
		# {'empleados', 'productos', 'clientes(*)'}
		when 'child_sel'
			# TIPO_NEW = 'child_sel'
			# TABLA_SEL = 'controller'
			"/#{controller.classify.constantize::TABLA_SEL}/seleccion?#{@objeto.class.name.downcase}_id=#{@objeto.id}"
		# TIPO_NEW = 'detalle_pedido' : seleccion ? parametro_padre & empresa
		# {'empleados', 'productos', 'clientes(*)'}
		when 'detalle_pedido'
			"/#{controller.classify.constantize::SELECTOR}/seleccion?#{@objeto.class.name.downcase}_id=#{@objeto.id}&empresa_id=#{@objeto.registro.empresa.id}"
		when 'ruta_new'
			controller.classify.constantize::RUTA_NEW
		end
	end


	def corrige(w)
		case w
		when 'Controlador'
			'label'
		else
			w.capitalize
		end
	end

	def link_estado(objeto)
		"/#{objeto.class.downcase.pluralize}/estado?estado="
	end
	def f_tabla(objeto)
		objeto.send(objeto.class::F_TABLA.singularize)
	end

	# Obtiene el campo para despleagar en una TABLA
	# Resuelve BT_FIELDS y d_<campo> si es necesario 
	def get_field(name, objeto)
		if objeto.class::column_names.include?(name) or (name.split('_')[0] == 'd')
			objeto.send(name)
		elsif objeto.class::BT_FIELDS.include?(name)
			o_bt = objeto.send(objeto.class::BT_MODEL)
			o.bt.send(name)
		else
			'FieldNotFound'
		end
	end

	def get_evaluacion_publicacion(publicacion, item)
		e = publicacion.evaluaciones.find_by(aspecto: item)
		e.blank? ? '[no evaluado]' : e.evaluacion
	end

	def get_btns_evaluacion(publicacion, item)
		eval_actual = publicacion.evaluaciones.find_by(aspecto: item)
		excluido = eval_actual.blank? ? [] : [eval_actual.evaluacion]
		Publicacion::EVALUACION[item] - excluido
	end

end
