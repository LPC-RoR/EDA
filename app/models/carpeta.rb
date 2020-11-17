class Carpeta < ApplicationRecord
	ESTADOS = ['activa']
	D_TABLA = {
		titulo:  true,
		tabs:    false,
		paginas: false,
		estados: false,
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
		titulo:   true,
		nav:      false,
		detalle:  false,
		tabs:     true,
		adjuntos: false,
		tablas:   false
	}

	has_many :clasificaciones
	has_many :textos, through: :clasificaciones

	def show_title
		self.carpeta
	end
end
