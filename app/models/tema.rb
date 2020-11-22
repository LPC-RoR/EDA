class Tema < ApplicationRecord
	HIDDEN_CHILDS = ['clasificaciones']
	# ------------------- TABLA -----------------------
	# Configura DESPLIEGUE de la TABLA
	D_TABLA = {
		tabs:    false,
		estados: false,
		paginas: false,
		nuevo:   true
	}

	# Campos qeu se despliegan en la tabla
	TABLA_FIELDS = [
		['tema',         'show']
	]

	# Tipo de LINK boton NUEVO
	TIPO_NEW = 'new'

	# Acceso a campos BT
#	BT_FIELDS = []	
#	BT_MODEL = ''

	# -------------------- FORM  -----------------------
 	FORM_FIELDS = [
		['tema',    'entry']
	]

	D_SHOW = {
		links:       true,
		detalle:     true,
		clasifica:   false,
		inline_form: false,
		tabs:        true,
		adjuntos:    false
	}

	SHOW_FIELDS = [
	]

	has_many :clasificaciones
	has_many :textos, through: :clasificaciones

	def show_title
		self.tema
	end
end
