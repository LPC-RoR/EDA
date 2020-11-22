class Revista < ApplicationRecord
	D_SHOW = {
		links:        true,
		detalle:     false,
		clasifica:   false,
		inline_form: false,
		tabs:         true,
		adjuntos:    false
	}

	belongs_to :idioma, optional: true

	has_many :publicaciones

	def show_title
		self.revista
	end
end
