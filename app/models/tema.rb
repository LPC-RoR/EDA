class Tema < ApplicationRecord

	TABLA_FIELDS = [
		['tema',         'show']
	]

	# -------------------- FORM  -----------------------
 	FORM_FIELDS = [
		['tema',             'entry']
	]

	has_many :clasificaciones
	has_many :textos, through: :clasificaciones

	has_many :herencias
	has_many :carpetas, through: :herencias

	def carpeta_tema(proyecto_id)
		proyecto_activo = Proyecto.find(proyecto_id)
		carpetas_proyecto = proyecto_activo.carpetas
		carpetas_tema = self.carpetas
		carpetas_despliegue = carpetas_proyecto & carpetas_tema
		carpetas = '| '
		carpetas_despliegue.each do |car|
			carpetas = carpetas + "#{car.carpeta} | "
		end
		"#{carpetas}#{self.tema}"
	end

end
