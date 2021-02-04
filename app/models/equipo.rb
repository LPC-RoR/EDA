class Equipo < ApplicationRecord

	belongs_to :administrador, class_name: 'Perfil'

	has_many :publicaciones
	has_many :carpetas

	has_many :integrantes
	has_many :perfiles, through: :integrantes

end
