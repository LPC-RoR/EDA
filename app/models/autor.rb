class Autor < ApplicationRecord
	belongs_to :investigadores
	belongs_to :publicaciones
end
