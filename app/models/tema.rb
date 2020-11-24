class Tema < ApplicationRecord
	HIDDEN_CHILDS = ['clasificaciones']
	# ------------------- TABLA -----------------------

	# Campos qeu se despliegan en la tabla
	TABLA_FIELDS = [
		['tema',         'show']
	]

	# Acceso a campos BT
#	BT_FIELDS = []	
#	BT_MODEL = ''

	# -------------------- FORM  -----------------------
 	FORM_FIELDS = [
		['tema',    'entry']
	]

	has_many :clasificaciones
	has_many :textos, through: :clasificaciones

	def show_title
		self.tema
	end
end
