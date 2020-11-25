class Equipo < ApplicationRecord

	TABS = ['Administrados', 'Participaciones']

	HIDDEN_CHILDS = ['integrantes']

	TABLE_EXCEPTIONS = {
		tabs:    {'self' => true}
	}

	TABLA_FIELDS = [
		['equipo', 'show'], 
	]

	SHOW_FIELDS = [
		['investigador', 'normal'],
		['sha1',         'normal']
	]

	MY_FIELDS = ['sha1']

	SHOW_EXCEPTIONS = [:detalle]

	F_TABLA = 'administrador'

	belongs_to :administrador, class_name: 'Investigador'

	has_many :publicaciones

	has_many :integrantes
	has_many :investigadores, through: :integrantes

	def show_title
		self.equipo
	end
end
