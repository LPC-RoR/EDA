class Perfil < ApplicationRecord

	TABLA_FIELDS = [
		['email', 'normal'], 
	]


	belongs_to :administrador, optional: true

	has_many :coautores
	has_many :colaboraciones, through: :coautores, source: :proyecto

	has_many :proyectos, foreign_key: 'administrador_id'

	has_many :evaluaciones

	has_many :mensajes

	# Duda si :publicaciones va o no
	has_many :publicaciones

end
