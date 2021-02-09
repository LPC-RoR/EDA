class Especificacion < ApplicationRecord

	TABLA_FIELDS = [
		['orden',        'normal'],
		['especificacion', 'show']
	]

	# -------------------- FORM  -----------------------
 	FORM_FIELDS = [
		['orden',          'entry'],
		['especificacion', 'entry'],
		['etapa_id', 'hidden']
	]

	belongs_to :tabla, optional: true
	belongs_to :etapa, optional: true

	def d_detalle
	  self.detalle.gsub(/\n/, '<br>')
	end
end
