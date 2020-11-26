class Recurso < ApplicationRecord
	# ---------------------------------------- CARGA ------------------------------------------------
	# Esta Constante debiera estar en el Modelo CARGA !!
	# Este es una constante que uso mientras no hay manejo de USUARIOS
	# -----------------------------------------TEMPORAL ------------------------------------------
	RUTA_ARCHIVOS= {
		'cargas' => "/home/hugo/eda/app/assets/cargas/"
	}

	# Controladores que tienen rutinas de Carga
	# Esta constante se usa para crear los directorios por USUARIO
	# Pendiente queda un helper o método en application_controller
	# NO USADO AUN
	CARGA_CONTROLLERS = ['cargas']
	# Estos controladores ponen la carga en una carpeta.
	# Buscar en el MODELO la constante Modelo::CARPETA_CARGA para seber cual
	# NO USADO AUN
	CARGA_HACIA_CARPETA_CONTROLLERS = ['cargas']
	
	# ---------------------------------------- DEFAULT -----------------------------------------------
	# ---------------------------------------- TABLE
	D_TABLA = {
		titulo:  {'self' => true,  'show' => false},
		tabs:    {'self' => false, 'show' => false}, 
		estados: {'self' => false, 'show' => false},
		paginas: {'self' => false, 'show' => false},
		nuevo:   {'self' => true,  'show' => false}
	}
	# Estos son los CONTROLADORES que tienen EXCEPCIONES
	# Buscar Modelo::TABLE_EXCEPTIONS
	EXCEPTIONS_CONTROLLERS = ['publicaciones', 'textos', 'recursos', 'equipos']
	# EXCEPCIONES en el COMPORTAMIENTO de NEW
	EXCEPTIONS_NEW_CONTROLLERS = {
		#'controller' => 'tipo_new'
		'publicaciones' => 'mask',
		'equipos' => 'inline_form'
	}

	# EXCEPCION en el CONTROLADOR RECURSOS
	# QUIZÁ DEBAMOS USAR OTRO CONTROLADOR PARA DESPLEGAR DESDE RECURSOS ???
	TABLE_EXCEPTIONS = {
		nuevo: ['recursos']
	}

	# ----------------------------------------- SHOW
	D_SHOW = {
		titulo:       true,
		links:        true,
		clasifica:   false,
		detalle:     false,
		inline_form: false,
		tabla:        true,
		adjuntos:    false
	}
	# MODELOS que teiene EXCEPCIONES
	# Buscar Modelo::SHOW_EXCEPTIONS
	EXCEPTIONS_MODELS = ['Publicacion', 'Texto', 'Equipo']

	# ---------------------------------------- FRAME ------------------------------------------------
	# MENU PRINCIPAL
	MENU = [
		["Publicaciones", "/publicaciones"],
		["Manual",  "/recursos/manual"],
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
	# Hasta el mínuto SOLO se usa 'manual'
	RECURSO_ACTIONS_DISPLAY = {
		'tablas'     => 'tabla',
		'manual' => 'tabla',
		'parametros' => 'valor'
	}

	# Acciones de Recurso que Tienen Título en el Frame
	RECURSO_ACTIONS_TITULO = {
		'manual' => '// Ingreso Manual de Publicaciones'
	}

	# Define qué actions de Recursos tienen TABS, y cada TAB
	# NO USADA EN ESTA APLICACION
	RECURSO_ACTIONS_TABS = {
		'tablas' => ['cargas', 'carpetas']
	}

	# --------------------------------------- MODELOS -----------------------------------------------
	# MODELOS que despliegan campos SOLO para PROPIETARIOS del modelo
	# Buscar Modelo::MY_FIELDS
	MODELS_WITH_SELF_FIELDS = ['Equipo']
	# Controladores que tienen HIDDEN CHILDS
	# Buscar Modelo::HIDDEN_CHILDS
	HIDDEN_CHILDS_CONTROLLERS = ['cargas', 'publicaciones', 'textos', 'carpetas', 'investigadores', 'temas', 'equipos']

	# --------------------------------------- NAVEGACION POR CONTEXTO
	# MODELOS QUE TIENEN LINKS
	# 'Carga' tiene el BOTON "Proceso"
	# Busacar en Modelo el Metodo show_links que devuelve una lista de botones
	SHOW_LINKS_MODELS = ['Carga']
	# MODELOS que despliegan LINKS para asociaciones BT y HMT
	# Buscar Modelo:: SHOW_BT_OBJECTS
	SHOW_BT_LINKS_MODELS = ['Publicacion']
	# Buscar Modelo::SHOW_HMT_COLLECTIONS
	SHOW_HMT_LINKS_MODELS = ['Publicacion', 'Texto']

end
