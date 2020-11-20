class Autor < ApplicationRecord
	belongs_to :investigador
	belongs_to :publicacion

	def show_title
		self.autor
	end
end
