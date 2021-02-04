class Perfil < ApplicationRecord

	TABLA_FIELDS = [
		['m_padre', 'show'], 
	]


	belongs_to :administrador, optional: true

	has_many :equipos, foreign_key: 'administrador_id'

	has_many :proyectos, foreign_key: 'administrador_id'

	has_many :temas	
	has_many :carpetas
	has_many :cargas
	has_many :ingresos, class_name: 'Publicacion'
	has_many :evaluaciones

	has_many :integrantes
	has_many :participaciones, through: :integrantes, source: :equipo

	has_many :coautores
	has_many :colaboraciones, through: :coautores, source: :proyecto

	def m_padre
		if self.investigador.present?
			self.investigador.email
		elsif self.equipo.present?
			self.equipo.equipo
		end				
	end
end
