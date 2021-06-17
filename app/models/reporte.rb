class Reporte < ApplicationRecord

	TABLA_FIELDS = [
		['reporte', 'show']
	]

 	FORM_FIELDS = [
		['reporte', 'entry'],
		['proyecto_id',         'hidden']
	]

	belongs_to :proyecto

	has_many :alcances
	has_many :carpetas, through: :alcances

	def carpetas_seleccion
		ids_proyecto = self.proyecto.carpetas.ids
		ids_reporte = self.carpetas.ids

		ids_seleccion = ids_proyecto - ids_reporte
		Carpeta.where(id: ids_seleccion)
	end
end
