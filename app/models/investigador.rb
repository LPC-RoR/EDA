class Investigador < ApplicationRecord
	belongs_to :departamentos

	has_many :autores
	has_many :publicaciones, through: :autores
end
