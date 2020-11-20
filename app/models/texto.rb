class Texto < ApplicationRecord
	HIDDEN_CHILDS = ['clasificaciones', 'citas']

	D_TABLA = {
		tabs:    false,
		paginas: false,
		estados: false,
		nuevo:   false
	}

	TABLA_FIELDS = [
		['texto',   'show']
	]

	TIPO_NEW = 'child_sel'
	TABLA_SEL = 'carpetas'

 	FORM_FIELDS = [
		['texto',           'entry']
	]

	D_SHOW = {
		titulo:     true,
		links:      true,
		nav:        false,
		detalle:    false,
		inline_form: true,
		tabs:       false,
		adjuntos:   false,
		tablas:     false
	}

	SHOW_HMT_COLLECTIONS = ['carpetas', 'publicaciones']

	has_many :clasificaciones
	has_many :carpetas, through: :clasificaciones

	has_many :citas
	has_many :publicaciones, through: :citas

	def show_title
		self.texto
	end
end
