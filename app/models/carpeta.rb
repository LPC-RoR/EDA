class Carpeta < ApplicationRecord
	NOT_MODIFY = ['Revisar', 'Excluidas', 'Postergadas', 'Revisadas']

	TABLA_FIELDS = [
		['carpeta', 'show'], 
	]

 	FORM_FIELDS = [
		['carpeta',              'entry'],
		['investigador_id',     'hidden']
	]

	HIDDEN_CHILDS = ['clasificaciones']
	SHOW_HMT_COLLECTIONS = ['publicaciones']

	belongs_to :investigador

	has_many :clasificaciones
	has_many :publicaciones, through: :clasificaciones

	def show_title
		self.carpeta
	end
end
