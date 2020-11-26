class Revista < ApplicationRecord
	# ---------------------------------------- SHOW
	D_SHOW = {
		links:        true,
		detalle:     false,
		clasifica:   false,
		inline_form: false,
		tabla:        true,
		adjuntos:    false
	}

	belongs_to :idioma, optional: true

	has_many :publicaciones

end
