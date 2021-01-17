class Equipo < ApplicationRecord

	# ----------------------------------------- TABS TABLE
	TABS = ['Administrados', 'Participaciones']

	# ----------------------------------------- HIDDEN CHILDS
	HIDDEN_CHILDS = ['integrantes']

	# ------------------------------------------------- TABLA
	T_EXCEPTIONS = {
		tabs:    ['self']
	}

	T_NEW_EXCEPTIONS = {
		#'controller' => 'tipo_new'
		# '*' en todo controller_name
		'*' => 'inline',
	}

	TABLA_FIELDS = [
		['equipo', 'show'], 
	]

	# ------------------------------------------------- SHOW
	SHOW_FIELDS = [
		['investigador', 'normal'],
		['sha1',         'normal']
	]

	SHOW_EXCEPTIONS = [:detalle]
	F_TABLA = 'administrador'

	# -------------------------------------------------- DESPLIEGUE
	MY_FIELDS = ['sha1']

	belongs_to :administrador, class_name: 'Investigador'

	has_many :publicaciones
	has_many :carpetas

	has_many :integrantes
	has_many :investigadores, through: :integrantes

end
