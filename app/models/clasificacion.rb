class Clasificacion < ApplicationRecord
	belongs_to :carpeta, optional: true
	belongs_to :tema, optional: true
	belongs_to :publicacion, optional: true
	belongs_to :texto, optional: true
end
