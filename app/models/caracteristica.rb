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

	def columna(objeto)
		if objeto.linea.present?
			if objeto.linea.columnas.any?
				objeto.linea.columnas.find_by(orden: self.orden)
			else
				nil
			end
		else
			nil
		end
	end

	def valor_referencia(objeto)
		(self.columna(objeto).blank? ? nil : self.columna(objeto).columna)
	end
end
