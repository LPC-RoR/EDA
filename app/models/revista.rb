class Revista < ApplicationRecord
	belongs_to :idioma

	has_many :publicaciones
end
