class Caracterizacion < ApplicationRecord

	TABLA_FIELDS = [
		['caracterizacion', 'show']
	]

 	FORM_FIELDS = [
		['caracterizacion', 'entry'],
		['proyecto_id',    'hidden']
	]

	belongs_to :proyecto

	has_many :caracteristicas

	def tablas
		Tabla.where(padre_class: 'Caracterizacion').where(padre_id: self.id)
	end

	def tabla
		self.tablas.first
	end

	def tabla?
		Tabla.where(padre_class: 'Caracterizacion').where(padre_id: self.id).any?
	end
end
