class Proyecto < ApplicationRecord
	# ----------------------------------------- TABS TABLE
	TABS = ['Administrados', 'Participaciones']

	# ----------------------------------------- HIDDEN CHILDS
	HIDDEN_CHILDS = ['coautores', 'herencias']

	# ------------------------------------------------- TABLA
	T_EXCEPTIONS = {
		tabs:    ['self']
	}

	TABLA_FIELDS = [
		['proyecto', 'show'], 
		['sha1',   'normal']
	]

	T_NEW_EXCEPTIONS = {
		#'controller' => 'tipo_new'
		# '*' en todo controller_name
		'*' => 'inline',
	}

	## BOTNES EXTRA REGISTRO
	# [0] : Nombre del boton
	# [1] : link base, a esta base se le agrega el instancia_id
	# [2] : Si es true se agrega "objeto_id=#{@objeto.id}"
	X_BTNS = [
		['Eliminar', '/equipos/', '/elimina_equipo', true]
	]

	# ------------------------------------------------- SHOW
	SHOW_FIELDS = [
		['email', 'normal'],
		['sha1',  'normal']
	]

	S_E = [:detalle, :inline_form]
	F_TABLA = 'administrador'

 	FORM_FIELDS = [
		['proyecto',           'entry'],
		['perfil_id',         'hidden'],
	]

	belongs_to :administrador, class_name: 'Perfil'

	has_many :coautores
	has_many :perfiles, through: :coautores

	has_many :herencias
	has_many :temas, through: :herencias
end
