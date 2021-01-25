class Clasificacion < ApplicationRecord
	CLASIFICACION = ['referencia', 'complementario', 'controversial', 'revisar']

	TABLA_FIELDS = [
		['clasificacion', 'normal'],
		['texto',         'bt_show']
	]

	## BOTNES EXTRA REGISTRO
	# [0] : Nombre del boton
	# [1] : link base, a esta base se le agrega el instancia_id
	# [2] : Si es true se agrega "objeto_id=#{@objeto.id}"
	X_BTNS = [
		['referencia',     '/clasificaciones/', '/clasifica?clasificacion=referencia'    , true],
		['complementario', '/clasificaciones/', '/clasifica?clasificacion=complementario', true],
		['controversial',  '/clasificaciones/', '/clasifica?clasificacion=controversial' , true],
		['revisar',        '/clasificaciones/', '/clasifica?clasificacion=revisar'       , true]
	]

	BT_FIELDS = ['texto']
	BT_MODEL = 'texto'

	belongs_to :carpeta, optional: true
	belongs_to :tema, optional: true
	belongs_to :publicacion, optional: true
	belongs_to :texto, optional: true

	def x_btns_conditions(btn, controller, action)
		case btn
		when 'referencia'
			self.clasificacion != 'referencia'
		when 'complementario'
			self.clasificacion != 'complementario'
		when 'controversial'
			self.clasificacion != 'controversial'
		when 'revisar'
			self.clasificacion != 'revisar'
		end
	end
end
