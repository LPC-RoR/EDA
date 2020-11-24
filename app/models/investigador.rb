class Investigador < ApplicationRecord

	HIDDEN_CHILDS = ['autores']

	D_SHOW = {
		links:        true,
		detalle:     false,
		clasifica:   false,
		inline_form: false,
		tabla:        true,
		adjuntos:    false
	}

	belongs_to :departamento, optional: true

	has_many :equipos, foreign_key: 'administrador_id'

	has_many :autores
	has_many :publicaciones, through: :autores

	has_many :integrantes
	has_many :participaciones, through: :integrantes, source: :equipo


	def show_title
		self.investigador
	end
end
