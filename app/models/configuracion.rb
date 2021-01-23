class Configuracion < ApplicationRecord
	## *****************************************************************************************************
	## ******************************* CONFIGURACION BASE **************************************************
	## *****************************************************************************************************

	## CONTROLADORES QUE TIENEN RUTINAS DE CARGA
	# dado el controlador y usuario/tipo de usuario sabremos donde poner el archivo y donde irlo a buscar
	CARGA_CONTROLLERS = ['cargas']

	## *****************************************************************************************************
	## ----------------------------------------   COMPORTAMIENTO POR DEFECTO
	## ----------------------------------------   TABLE
	# Se verifica con el helper in_t?(c, label)
	T_DEFAULT = {
		titulo:  {'self' => true,  'show' => false},
		tabs:    {'self' => false, 'show' => false}, 
		estados: {'self' => false, 'show' => false},
		paginas: {'self' => false, 'show' => false},
		nuevo:   {'self' => true,  'show' => false}
	}

	# -----------------------------------------   SHOW
	S_DEFAULT = {
		titulo:       true,
		links:        true,
		clasifica:   false,
		detalle:     false,
		inline_form: false,
	 	tabla:        true,
		adjuntos:    false
	}

	## *****************************************************************************************************
	## ******************************* CONFIGURACION APLICACION ********************************************
	## *****************************************************************************************************
	# -----------------------------------------   MENÚ PRINCIPAL
	MENU = [
		["Publicaciones", "/publicaciones",   'publicaciones', 'index'],
		["Manual",        "/recursos/manual", 'recursos',      'manual'],
		["Equipos",       "/equipos",         'equipos',       'index'],
		["Textos",        "/textos",          'textos',        'index'],
		["Carpetas",      "/carpetas",        'carpetas',      'index'],
		["Temas",         "/temas",           'temas',         'index'],
		["Cargas",        "/cargas",          'cargas',        'index'] 
	]

	# CONTROLADORES que NO despliegan el MENU PRINCIPAL
	M_E_CONTROLLERS = ['confirmations', 'mailer', 'passwords', 'registrations', 'sessions', 'unlocks']

	# ITEMS de MENU que requieren USUARIO AUTENTICADO
	M_I_SIGN_IN = ['Publicaciones', 'Manual', 'Equipos', 'Textos', 'Carpetas', 'Temas', 'Cargas']
	# ITEMS de MENU que requieren USUARIO AUTENTICADO ADMINISTRATIVO
	M_I_ADMIN = []
	# ITEMS de MENU para TODO USUARIO (ANONIMO INCLUIDO)
	M_I_ANONIMOS = []

	## *****************************************************************************************************
	# -----------------------------------------   COLECCIONES PROPIAS
	# COLECCION_PROPIA = una colección que puede ser gestionada SIN preguntar registro a registro si se puede
	# NO sól es aplicable a una acción 'index'
	# Cuando se aplica a un SHOW, las colecciones que se despliegan en él son PROPIAS
	COLECCIONES_PROPIAS = [
		'publicaciones#index',
		'recursos#manual',
		'equipos#index',
		'carpetas#index',
		'temas#index',
		'cargas#index',
		'cargas#show',
		'carpetas#show'
	]

	# -----------------------------------------   COLECCIONES PROPIAS
	# OBJETO_PROPIO = Objeto que se puede gestionar en libertad
	OBJETOS_PROPIOS = [
		'carpetas#show',
		'temas#show',
		'cargas#show'
	]

	# -----------------------------------------   CONFIGURACIÓN DE CONTROLADORES
	## *****************************************************************************************************
	# -----------------------------------------   FRAME
	# TODOS los MODELOS FRAME TIRNEN EL TITULO EN EL MODELO
	# LOS MODELOS DE CONTROLADORES CON FRAME TIENEN EL TITULO EN EL MODELO
	# Modelo::TITULO
	# TITULO = {
	#	'index'      => 'Colecciones',
	#	'escritorio' => 'Escritorio'
	#}
	# CONTROLADORES FRAME con TABS
	FRAME_WITH_TABS_CONTROLLERS = []
	# En el Modelo buscar Modelo::FRAME_TABS
	# FRAME_TABS = {
	#	'index' => ['Completa', 'Pendiente']
	# }

	# LOS MODELOS DE BI_FRAME TIENEN FRAME_SELECTOR
	# FRAME_SELECTOR = {
	#	'index'      => 'Áreas'
	# }

	# LOS MODELOS DE FRAME TIENEN ACTION_TYPE
	# FRAME_ACTIONS_TYPE = {
	#	'index'      => 'tabla',
	#	'escritorio' => 'tabla'
	#	'parametros' => 'valor'
	# }

	## *****************************************************************************************************
	# -----------------------------------------   TABLA
	# -----------------------------------------   EXCEPTIONS
	# Estos son los CONTROLADORES que tienen EXCEPCIONES
	# Buscar Modelo::T_EXCEPTIONS
	# USADA SOLO POR in_t? para saber donde buscar Excepciones
	T_E_CONTROLLERS = ['publicaciones', 'textos', 'recursos', 'equipos']
	# Buscar Modelo::T_EXCEPTIONS
	# T_EXCEPTIONS = {
	#	tabs:    ['self'],
	#	paginas: ['*'],
	#	nuevo:   ['self', 'contribuciones']
	#}

	# -----------------------------------------   NEW
	T_E_NEW_CONTROLLERS = ['equipos']
	# Model::T_NEW_EXCEPTIONS
	# T_NEW_EXCEPTIONS = {
	#	#'controller' => 'tipo_new'
	#	'*' => 'mask',
	#	'equipos' => 'inline'
	#}

	# -----------------------------------------   BOTONES DEL REGISTRO
	# -----------------------------------------   CONTROL DE DESPLIEGUE DE BOTONES
	# Botones con despliegue condicional
	# Buscar MODELO.btns_control, este método controla el despliegue 
	T_E_LINE_BTNS_MODELS = [] 
	# DEFINICION DE BOTONES ADICIONALES
	T_E_ADDITIONAL_BTNS_MODEL = ['Equipo', 'Carga']
	# Byscar en MODELO::X_BTNS

	## *****************************************************************************************************
	# -----------------------------------------   FORM
	FORM_E_DETAIL = ['Publicacion']
	FORM_CONDITIONAL_FIELDS_MODELS = ['Publicacion']

	## *****************************************************************************************************
	# -----------------------------------------   SHOW
	# MODELOS que teiene EXCEPCIONES
	# Buscar Modelo::S_E
	S_E_MODELS = ['Publicacion', 'Texto', 'Equipo']
	# Excepción en el TITULO
	S_E_TITLE_MODELS = ['Publicacion', 'Carga']
	# Modelos que tienen STATUS para desplegar en el SHOW
	# Buscar Model::self.status
	S_STATUS_MODELS = ['Carga']

	# MODELOS que despliegan campos SOLO para PROPIETARIOS del modelo
	# REEMPLAZAR CON CAMPOS CONDICIONALES (MAS ADELANTE)
	# Buscar Modelo::MY_FIELDS
	MODELS_WITH_SELF_FIELDS = ['Equipo']

	# -- SHOW : LINKS + NAVEGACION POR CONTEXTO
	# MODELOS QUE TIENEN LINKS
	# 'Carga' tiene el BOTON "Proceso"
	# Busacar en Modelo el Metodo show_links que devuelve una lista de botones
	S_LINKS_MODELS = ['Carga', 'Publicacion']
	# MODELOS que despliegan LINKS para asociaciones BT y HMT
	# Buscar Modelo:: S_BT_LINKS_OBJECTS
	S_BT_LINKS_MODELS = ['Publicacion']
	# Buscar Modelo::S_HMT_LINKS_COLLECTIONS
	S_HMT_LINKS_MODELS = ['Publicacion']

	# Controladores que tienen HIDDEN CHILDS
	# Buscar Modelo::HIDDEN_CHILDS
	HIDDEN_CHILDS_CONTROLLERS = ['cargas', 'publicaciones', 'textos', 'carpetas', 'investigadores', 'temas', 'equipos']

end
