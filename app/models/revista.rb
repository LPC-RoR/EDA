class Revista < ApplicationRecord
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

	belongs_to :idioma

	has_many :publicaciones

	def show_title
		self.revista
	end
end
