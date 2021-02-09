class Observacion < ApplicationRecord

	TABLA_FIELDS = [
		['observacion', 'show']
	]

	# -------------------- FORM  -----------------------
 	FORM_FIELDS = [
		['observacion', 'entry'],
		['etapa_id',   'hidden']
	]

	belongs_to :columna, optional: true
	belongs_to :linea, optional: true
	belongs_to :tabla, optional: true

	def d_detalle
	  self.detalle.blank? ? '' : self.detalle.gsub(/\n/, '<br>')
	end
end
