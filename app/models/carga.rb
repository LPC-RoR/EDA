class Carga < ApplicationRecord

	HIDDEN_CHILDS = ['procesos']

	ESTADOS = ['ingreso', 'procesado']

	TABLA_FIELDS = [
		['d_archivo',   'show'], 
		['nota',      'normal']
	]
	TIPO_NEW = 'ruta_new'
	RUTA_NEW = '/recursos/sel_archivo_carga'

 	FORM_FIELDS = [
		['nota',             'entry'],
		['estado',          'hidden'],
		['investigador_id', 'hidden'],
		['archivo',         'hidden']
	]

	belongs_to :investigador

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
