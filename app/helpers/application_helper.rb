module ApplicationHelper
	# Obtiene los controladores que no despliegan menu
	def nomenu?(controller)
		Recurso::NOMENU_CONTROLLERS.include?(controller)
	end
	# Pregunta si la "accion" del "recursos_controller" despluega TABS
	# "_frame.html.erb"
	def r_tabs?(accion)
		Recurso::TAB_ACTIONS.include?(accion)
	end
	# Pregunta si la "accion" del "recursos_controller" despluega TABLA
	# "_frame.html.erb"
	def r_tabla?(accion)
		Recurso::TABLE_ACTIONS.include?(accion)
	end
	def tabs?(controller)
		Recurso::TABS_CONTROLLERS.include?(controller)
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
		else
			controller
		end
	end
	# En un modelo donde "ftab" es el tab del frame, "tab" el del modelo y "estado" el que controla los estados de la tabla
	# este método entrega el link para el manejo de cada tab entregando el controlador y la variable {'ftab', 'tab', 'estado'}
	def get_link(c, var)
		case var
		when 'ftab'
			"/#{controller_name}/#{action_name}?ftab="
		when 'tab'
			action_name == 'show' ? "/#{controller_name}/#{@objeto.id}?tab=" : "/#{controller_name}/#{action_name}?ftab=#{@ftab}&tab="
		when 'estado'
			if action_name == 'show'
				has_many_tabs(controller_name).empty? ? "/#{controller_name}/#{@objeto.id}?estado=" : "/#{controller_name}/#{@objeto.id}?tab=#{@tab}&estado="
			else
				tabs?(c) ? "/#{controller_name}/#{action_name}?ftab=#{@ftab}&tab=#{@tab}&estado=" : "/#{controller_name}/#{action_name}?ftab=#{@ftab}&estado="
			end
		end
	end
	# Consulta en el modelo que elmentos de la tabla se deben desplegar
	def d_tabla(controller, label)
		controller.classify.constantize::D_TABLA[label]
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


	def d_show(controller, label)
		controller.classify.constantize::D_SHOW[label]
	end

	def has_many_tabs(controller)
		controller.classify.constantize.reflect_on_all_associations(:has_many).map {|a| a.name.to_s} - Recurso::JOIN_TABLES
	end

	def get_new_link(controller)
		case controller.classify.constantize::TIPO_NEW
		# TIPO_NEW = 'new'
		# {'clientes', 'roles'}
		when 'new'
			"/#{controller}/new"
		# TIPO_NEW = 'child_new' : show_padre + controller/new
		# {'categorias', 'zonas'}
		when 'child_new'
			"/#{@objeto.class.name.downcase.pluralize}/#{@objeto.id}/#{controller}/new"
		# TIPO_NEW = 'child_nuevo'
		# {'pedidos'}
		when 'child_nuevo'
			"/#{controller}/nuevo?#{@objeto.class.name.downcase}_id=#{@objeto.id}"
		# TIPO_NEW = 'child_sel' : seleccion ? parametro_padre
		# {'empleados', 'productos', 'clientes(*)'}
		when 'child_sel'
			"/#{controller.classify.constantize::SELECTOR}/seleccion?#{@objeto.class.name.downcase}_id=#{@objeto.id}"
		# TIPO_NEW = 'detalle_pedido' : seleccion ? parametro_padre & empresa
		# {'empleados', 'productos', 'clientes(*)'}
		when 'detalle_pedido'
			"/#{controller.classify.constantize::SELECTOR}/seleccion?#{@objeto.class.name.downcase}_id=#{@objeto.id}&empresa_id=#{@objeto.registro.empresa.id}"
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

	def has_child?(objeto)
		# NO MENJA BIEN EL CASO DE HAS_MANY THROUGH
		objeto.class.reflect_on_all_associations(:has_many).map { |a| ( Recurso::JOIN_TABLES.include?(a.name.to_s) ? 'false' : objeto.send(a.name).any? ) }.include?(true)
	end
	def link_estado(objeto)
		"/#{objeto.class.downcase.pluralize}/estado?estado="
	end
	def f_tabla(objeto)
		objeto.send(objeto.class::F_TABLA.singularize)
	end

end
