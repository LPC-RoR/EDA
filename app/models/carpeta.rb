class Carpeta < ApplicationRecord
	# MARCA CARPETAS QUE NO SE MODIFICAN NI ELIMINAN
	NOT_MODIFY = ['Carga', 'Ingreso', 'Duplicados', 'Revisar', 'Excluidas', 'Postergadas', 'Revisadas']

	# ----------------------------------------- HIDDEN CHILDS
	HIDDEN_CHILDS = ['clasificaciones']

	#-------------------------------------------------------------  TABLA
	T_EXCEPTIONS = {
		nuevo:   ['equipos']
	}

	T_NEW_EXCEPTIONS = {
		#'controller' => 'tipo_new'
		# '*' en todo controller_name
		'equipos' => 'inline',
	}

	TABLA_FIELDS = [
		['carpeta', 'show'], 
	]

 	FORM_FIELDS = [
		['carpeta',        'entry'],
		['perfil_id',     'hidden']
	]

	# ------------------------------------------------------------- DESPLIEGUE
	# ANTIGUO: VERIFFICAR
	SHOW_HMT_COLLECTIONS = ['publicaciones']

	belongs_to :perfil, optional: true
	belongs_to :equipo, optional: true

	has_many :clasificaciones
	has_many :publicaciones, through: :clasificaciones

	def btns_control
		not NOT_MODIFY.include?(self.carpeta)
	end

end
