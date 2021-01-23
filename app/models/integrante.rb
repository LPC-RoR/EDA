class Integrante < ApplicationRecord
	belongs_to :perfil
	belongs_to :equipo
end
