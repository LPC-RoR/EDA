class Texto < ApplicationRecord
	HIDDEN_CHILDS = ['clasificaciones', 'citas']

	D_TABLA = {
		tabs:    false,
		estados: false,
		paginas: false,
		nuevo:   false
	}

	TABLA_FIELDS = [
		['texto',   'show']
	]

	TIPO_NEW = 'child_sel'
	TABLA_SEL = 'temas'

 	FORM_FIELDS = [
		['texto',           'entry']
	]

	D_SHOW = {
		links:       true,
		detalle:    false,
		clasifica:  false,
		inline_form: true,
		tabs:       false,
		adjuntos:   false
	}

	SHOW_HMT_COLLECTIONS = ['temas', 'publicaciones']

	has_many :clasificaciones
	has_many :temas, through: :clasificaciones

	has_many :citas
	has_many :publicaciones, through: :citas

	def show_title
		self.texto
	end
end
