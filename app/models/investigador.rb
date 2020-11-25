class Investigador < ApplicationRecord

	TABLA_FIELDS = [
		['investigador',         'show']
	]

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

	has_many :carpetas
	has_many :temas
	has_many :cargas
	has_many :equipos, foreign_key: 'administrador_id'
	has_many :evaluaciones
	has_many :publicaciones

	has_many :autores
	has_many :publicaciones, through: :autores

	has_many :integrantes
	has_many :participaciones, through: :integrantes, source: :equipo


	def show_title
		self.investigador
	end
end
