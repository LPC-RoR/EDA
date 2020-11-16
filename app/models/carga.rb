class Carga < ApplicationRecord

	ESTADOS = ['ingreso', 'procesado']
	D_TABLA = {
		titulo:  true,
		tabs:    false,
		paginas: false,
		estados: true,
		nuevo:   true
	}
	TABLA_FIELDS = [
		['archivo', 'show'], 
		['nota',  'normal']
	]
	TIPO_NEW = 'sel_archivo_carga'

 	FORM_FIELDS = [
		['nota',    'entry'],
		['estado', 'hidden'],
		['archivo','hidden'],
	]


	D_SHOW = {
		titulo:   true,
		nav:      false,
		detalle:  false,
		tabs:     true,
		adjuntos: false,
		tablas:   false
	}

	has_many :publicaciones

	def show_title
		self.archivo.split('/').last
	end

end
