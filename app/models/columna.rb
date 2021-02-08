class Columna < ApplicationRecord
	belongs_to :linea

	has_one :valor
	has_many :archivos
	has_many :observaciones
end
