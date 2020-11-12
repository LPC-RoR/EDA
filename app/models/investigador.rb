class Investigador < ApplicationRecord
	belongs_to :departamento

	has_many :autores
	has_many :publicaciones, through: :autores
end
