class Repositorio < ApplicationRecord
	has_many :origenes
	has_many :publicaciones, through: :origenes
end
