class Carga < ApplicationRecord

	HIDDEN_CHILDS = ['procesos']

	ESTADOS = ['ingreso', 'procesado']
	D_TABLA = {
		tabs:    false,
		estados: false,
		paginas: false,
		nuevo:   true
	}
	TABLA_FIELDS = [
		['d_archivo',   'show'], 
		['nota',      'normal']
	]
	TIPO_NEW = 'ruta_new'
	RUTA_NEW = '/recursos/sel_archivo_carga'

 	FORM_FIELDS = [
		['nota',    'entry'],
		['estado', 'hidden'],
		['archivo','hidden'],
	]


	D_SHOW = {
		links:        true,
		detalle:     false,
		clasifica:   false,
		inline_form: false,
		tabla:        true,
		adjuntos:    false
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
