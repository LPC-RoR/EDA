class Investigador < ApplicationRecord

	HIDDEN_CHILDS = ['autores']

	D_SHOW = {
		links:        true,
		detalle:     false,
		clasifica:   false,
		inline_form: false,
		tabs:         true,
		adjuntos:    false
	}

	belongs_to :departamento, optional: true

	has_many :autores
	has_many :publicaciones, through: :autores

	def show_title
		self.investigador
	end
end
