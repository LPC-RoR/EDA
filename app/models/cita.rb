class Cita < ApplicationRecord
	belongs_to :publicacion
	belongs_to :texto
end
