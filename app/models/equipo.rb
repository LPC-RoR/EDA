class Equipo < ApplicationRecord

	TABS = ['Administrados', 'Participaciones']

	TABLE_EXCEPTIONS = {
		tabs:    {'self' => true}
	}

	TABLA_FIELDS = [
		['equipo', 'show'], 
	]

	belongs_to :administrador, class_name: 'Investigador'

	has_many :integrantes
	has_many :investigadores, through: :integrantes
end
