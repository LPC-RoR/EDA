class Investigador < ApplicationRecord

	HIDDEN_CHILDS = ['autores']

	D_SHOW = {
		titulo:       true,
		links:        true,
		nav:         false,
		detalle:     false,
		inline_form: false,
		tabs:         true,
		adjuntos:    false,
		tablas:       true
	}

	belongs_to :departamento, optional: true

	has_many :autores
	has_many :publicaciones, through: :autores

	def show_title
		self.investigador
	end
end
