class Texto < ApplicationRecord
	# ----------------------------------------- HIDDEN CHILDS
	HIDDEN_CHILDS = ['clasificaciones', 'citas']

	# ------------------------------------------ TABLA
	TABLA_FIELDS = [
		['texto',   'show']
	]

	T_EXCEPTIONS = {
		nuevo:    ['self']
	}

	# NO SE OCUPA, REVISAR
 	FORM_FIELDS = [
		['texto',           'entry']
	]

	# ------------------------------------------ SHOW
	SHOW_EXCEPTIONS = [:inline_form, :tabla]

	# ------------------------------------------ DESPLIEGUE

	SHOW_HMT_COLLECTIONS = ['temas', 'publicaciones']

	## BOTNES EXTRA REGISTRO
	# [0] : Nombre del boton
	# [1] : link base, a esta base se le agrega el instancia_id
	# [2] : Si es true se agrega "objeto_id=#{@objeto.id}"
	X_BTNS = [
		['Eliminar', '/textos/', '/remueve_texto', true]
	]

	has_many :clasificaciones
	has_many :temas, through: :clasificaciones

	has_many :citas
	has_many :publicaciones, through: :citas

	def x_btns_conditions(btn, controller, action)
		case btn
		when 'Eliminar'
			controller == 'publicaciones'
		end
	end

end
