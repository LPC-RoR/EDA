class Recurso < ApplicationRecord
	# ---------------------------------------- CARGA ------------------------------------------------
	# Esta Constante debiera estar en el Modelo CARGA !!
	RUTA_ARCHIVOS= {
		'cargas' => "/home/hugo/eda/app/assets/cargas/"
	}
	
	# Carpeta destino de Publicaciones Cargadas
	CARPETA_CARGA = 'Revisar'

	#---------------------------------------- DEFAULT -----------------------------------------------y
	# TABLE
	D_TABLA = {
		titulo:  {'self' => true,  'show' => false},
		tabs:    {'self' => false, 'show' => false}, 
		estados: {'self' => false, 'show' => false},
		paginas: {'self' => false, 'show' => false},
		nuevo:   {'self' => true,  'show' => false}
	}
	EXCEPTIONS_CONTROLLERS = ['publicaciones', 'textos', 'recursos', 'equipos']
	EXCEPTIONS_NEW_CONTROLLERS = {
		#'controller' => 'tipo_new'
		'publicaciones' => 'mask',
		'equipos' => 'inline_form'
	}


	TABLE_EXCEPTIONS = {
		nuevo: ['recursos']
	}

	# SHOW
	D_SHOW = {
		titulo:       true,
		links:        true,
		clasifica:   false,
		detalle:     false,
		inline_form: false,
		tabla:        true,
		adjuntos:    false
	}
	EXCEPTIONS_MODELS = ['Publicacion', 'Texto']

	# ---------------------------------------- FRAME ------------------------------------------------
	# MENU PRINCIPAL
	MENU = [
		["Publicaciones", "/publicaciones"],
		["Manual",  "/recursos/produccion"],
		["Equipos",  "/equipos"],
		["Textos", "/textos"],
		["Carpetas", "/carpetas"],
		["Temas", "/temas"],
		["Cargas", "/cargas"] 
	]

	# CONTROLADORES que NO despliegan el MENU PRINCIPAL
	# Evalualremos la existencia del MENU PRINCIPAL, es posible NO usarlo?
	NOMENU_CONTROLLERS = ['confirmations', 'mailer', 'passwords', 'registrations', 'sessions', 'unlocks']

	# Controladores con TABS de FRAME
	# Antiguo TABS_CONTROLLERS
	FRAME_CONTROLLERS = ['recursos']

	# Cada acción SOLO despliega un tipo 'tabla' o 'valor', para simplifaicar
	RECURSO_ACTIONS_DISPLAY = {
		'tablas'     => 'tabla',
		'produccion' => 'tabla',
		'parametros' => 'valor'
	}

	# Acciones de Recurso que Tienen Título en el Frame
	RECURSO_ACTIONS_TITULO = {
		'produccion' => '// Ingreso Manual de Publicaciones'
	}

	# Define qué actions de Recursos tienen TABS, y cada TAB
	RECURSO_ACTIONS_TABS = {
		'tablas' => ['cargas', 'carpetas'],
		'produccion' => ['Referencia', 'Produccion']
	}

	# --------------------------------------- MODELOS -----------------------------------------------
	# Controladores que tienen HIDDEN CHILDS
	# en el modelo se especifican con la constante HIDDEN_CHILDS
	# en la versión anterior se usaba JOIN_TABLES
	# se resolvió TODO lo de JOIN_TABLE menos su uso en _btns.html.erb que se puso en comentario
	HIDDEN_CHILDS_CONTROLLERS = ['cargas', 'publicaciones', 'textos', 'carpetas', 'investigadores', 'temas']

	# NAVEGACION POR CONTEXTO
	SHOW_LINKS_MODELS = ['Carga']
	SHOW_BT_LINKS_MODELS = ['Publicacion']
	SHOW_HMT_LINKS_MODELS = ['Publicacion', 'Texto']

	# SHOW INLINE FORMS
	INLINE_FORM_MODELS = ['Publicacion']

end
