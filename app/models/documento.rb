class Documento < ApplicationRecord

	TABLA_FIELDS = [
		['documento',      'show'],
		['d_version', 'link_file']
	]

 	FORM_FIELDS = [
		['documento',        'entry'],
		['proyecto_id',     'hidden']
	]

	belongs_to :proyecto

	has_many :archivos

	def d_version
		self.archivos.empty? ? nil : self.archivos.order(created_at: :desc).first.archivo
	end
end
