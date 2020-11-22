class Recurso < ApplicationRecord
	# ---------------------------------------- CARGA ------------------------------------------------
	# Esta Constante debiera estar en el Modelo CARGA !!
	RUTA_ARCHIVOS_CARGA = "/home/hugo/eda/app/assets/cargas/**/*"
	# Carpeta destino de Publicaciones Cargadas
	CARPETA_CARGA = 'Revisar'

	# ---------------------------------------- FRAME ------------------------------------------------
	# MENU PRINCIPAL
	MENU = [
		["Publicaciones", "/publicaciones"],
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
	ACTIONS_DISPLAY = {
		'tablas'     => 'tabla',
		'parametros' => 'valor'
	}

	# Define qué actions de Recursos tienen TABS, y cada TAB
	ACTIONS_TABS = {
		'tablas' => ['cargas', 'carpetas']
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

	# ----------------------------------------- NEW -------------------------------------------------
	# Controladores cuyas tablas usan inline_form
	ENTRY_NEW_CONTROLLERS = []
end
