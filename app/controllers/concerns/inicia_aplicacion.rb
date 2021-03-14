module IniciaAplicacion
	extend ActiveSupport::Concern

	def inicia_app

		#Carga Proyecto ACTIVO
		proyectos_activos = Proyecto.where(activo: true)
		unless proyectos_activos.empty?
			session[:proyecto_activo] = proyectos_activos.first
			session[:hay_proyecto] = true
		else
			session[:hay_proyecto] = false
		end

		if session[:hay_proyecto]
			proyecto_activo = Proyecto.find(session[:proyecto_activo].id)

			# Crea Carpetas Base por usuarios		
			if proyecto_activo.carpetas.empty?
				Carpeta::NOT_MODIFY.each do |car|
					proyecto_activo.carpetas.create(carpeta: car)
				end
			end
		end

	end
end