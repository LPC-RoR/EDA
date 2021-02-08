class Archivo < ApplicationRecord
	belongs_to :linea
	belongs_to :columna
end
