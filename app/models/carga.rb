class Carga < ApplicationRecord

	HIDDEN_CHILDS = ['procesos']

	ESTADOS = ['ingreso', 'procesado']
	D_TABLA = {
		tabs:    false,
		paginas: false,
		estados: true,
		nuevo:   true
	}
	TABLA_FIELDS = [
		['d_archivo',   'show'], 
		['nota',      'normal']
	]
	TIPO_NEW = 'sel_archivo_carga'

 	FORM_FIELDS = [
		['nota',    'entry'],
		['estado', 'hidden'],
		['archivo','hidden'],
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

	has_many :procesos
	has_many :publicaciones, through: :procesos

	def show_links
		[
			['Proceso', "/cargas/#{self.id}/procesa_carga"]
		]
		
	end

	def show_title
		self.archivo.split('/').last
	end

	def d_archivo
		self.archivo.split('/').last
	end

end
