class Caracteristica < ApplicationRecord

	TABLA_FIELDS = [
		['orden',          'normal'],
		['caracteristica',   'show'],
		['nombre_columna', 'normal'],
		['tipo',           'normal']
	]

 	FORM_FIELDS = [
 		['orden',               'entry'],
		['caracteristica',      'entry'],
		['nombre_columna',      'entry'],
		['tipo',                'entry'],
		['caracterizacion_id', 'hidden']
	]

	belongs_to :caracterizacion

	has_many :opciones

	def columna(objeto, caracterizacion)
		if objeto.linea(caracterizacion).present?
			if objeto.linea(caracterizacion).columnas.any?
				objeto.linea(caracterizacion).columnas.find_by(orden: self.orden)
			else
				nil
			end
		else
			nil
		end
	end

	def valor_referencia(objeto, caracterizacion)
		(self.columna(objeto, caracterizacion).blank? ? nil : self.columna(objeto, caracterizacion).columna)
	end
end
