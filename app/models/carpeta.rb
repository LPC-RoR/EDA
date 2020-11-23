class Carpeta < ApplicationRecord
	ESTADOS = ['activa']

	TABLA_FIELDS = [
		['carpeta', 'show'], 
	]

	TIPO_NEW = 'new'

 	FORM_FIELDS = [
		['carpeta',                'entry']
	]

	HIDDEN_CHILDS = ['clasificaciones']
	SHOW_HMT_COLLECTIONS = ['publicaciones']

	has_many :clasificaciones
	has_many :publicaciones, through: :clasificaciones

	def show_title
		self.carpeta
	end
end
