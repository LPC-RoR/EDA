class Recurso < ApplicationRecord

	RUTA_ARCHIVOS_CARGA = "/home/hugo/eda/app/assets/cargas/**/*"

	# GENERAL
	# CONTROLADORES que NO despliegan el MENU SUPERIOR
	NOMENU_CONTROLLERS = ['confirmations', 'mailer', 'passwords', 'registrations', 'sessions', 'unlocks']
	# Controladores con TABS
	TABS_CONTROLLERS = ['recursos']

	# estoy tratando de generalizar el despliegue de tablas JOIN
	JOIN_TABLES = []

	# RECURSOS
	# ACCIONES de "recursos_controller" que DESPLIEGAN TABS
	TAB_ACTIONS = ['tablas']
	# ACCIONES de "recursos_controller" que DESPLIEGAN TABLAS
	TABLE_ACTIONS = ['tablas']

	# TABS de la acción "tablas" de "recursos_controller"
	TABS = ['empresas', 'roles']

end
