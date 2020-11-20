class Carpeta < ApplicationRecord
	ESTADOS = ['activa']
	D_TABLA = {
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
		links:    true,
		nav:      false,
		detalle:  false,
		tabs:     true,
		adjuntos: false,
		tablas:   false
	}

	HIDDEN_CHILDS = ['clasificaciones']
	SHOW_HMT_COLLECTIONS = ['textos']

	has_many :clasificaciones
	has_many :textos, through: :clasificaciones

	def show_title
		self.carpeta
	end
end
