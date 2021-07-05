class Linea < ApplicationRecord

	TABLA_FIELDS = [
		['orden',     'normal'],
		['linea',      'show']
	]

	# -------------------- FORM  -----------------------
 	FORM_FIELDS = [
		['orden',        'entry'],
		['linea',        'entry'],
#		['archivo', 'file_field'],
		['tabla_id',    'hidden']
	]

	belongs_to :tabla, optional: true

	has_many :columnas
	has_many :archivos
	has_many :imagenes
	has_many :observaciones

	def referencia
		self.referencia_class.constantize.find(self.referencia_id)
	end

	def referencia?
		self.referencia.present?
	end
end
