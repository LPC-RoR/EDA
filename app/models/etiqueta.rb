class Etiqueta < ApplicationRecord

	TABLA_FIELDS = [
		['d_etiqueta',        'show'],
		['n_pubs', 'normal']
	]

	belongs_to :proyecto

	has_many :etq_contadores
	has_many :publicaciones, through: :etq_contadores

	def d_etiqueta
		self.etiqueta.capitalize
	end

	def n_pubs
		self.publicaciones.count
	end
end
