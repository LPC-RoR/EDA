class Texto < ApplicationRecord
	HIDDEN_CHILDS = ['clasificaciones', 'citas']


	TABLE_EXCEPTIONS = {
		nuevo:   ['*']
	}

	TABLA_FIELDS = [
		['texto',   'show']
	]

	TIPO_NEW = 'child_sel'
	TABLA_SEL = 'temas'

 	FORM_FIELDS = [
		['texto',           'entry']
	]

	SHOW_EXCEPTIONS = [:inline_form, :tabla]

	SHOW_HMT_COLLECTIONS = ['temas', 'publicaciones']

	has_many :clasificaciones
	has_many :temas, through: :clasificaciones

	has_many :citas
	has_many :publicaciones, through: :citas

	def show_title
		self.texto
	end
end
