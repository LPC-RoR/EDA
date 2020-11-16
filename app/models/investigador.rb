class Investigador < ApplicationRecord
	belongs_to :departamento, optional: true

	has_many :autores
	has_many :publicaciones, through: :autores
end
