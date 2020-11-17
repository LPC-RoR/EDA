class Texto < ApplicationRecord
	has_many :clasificaciones
	has_many :carpetas, through: :clasificaciones

	has_many :citas
	has_many :publicaciones, through: :citas
end
