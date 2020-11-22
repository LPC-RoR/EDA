class Carpeta < ApplicationRecord
	ESTADOS = ['activa']
	D_TABLA = {
		tabs:    false,
		estados: false,
		paginas: false,
		nuevo:   true
	}
	TABLA_FIELDS = [
		['carpeta', 'show'], 
	]

	TIPO_NEW = 'new'

 	FORM_FIELDS = [
		['carpeta',                'entry']
	]


	D_SHOW = {
		links:        true,
		detalle:     false,
		clasifica:   false,
		inline_form: false,
		tabla:        true,
		adjuntos:    false
	}

	HIDDEN_CHILDS = ['clasificaciones']
	SHOW_HMT_COLLECTIONS = ['publicaciones']

	has_many :clasificaciones
	has_many :publicaciones, through: :clasificaciones

	def show_title
		self.carpeta
	end
end
