class Publicacion < ApplicationRecord
	belongs_to :registro
	belongs_to :revista

	has_many :taxtos
	has_many :metodologias

	has_many :autores
	has_many :investigadores, through: :autores

	has_many :origenes
	has_many :repositorios, through: :origenes

	has_many :referencias
	has_many :conceptos, through: :referencias
end
