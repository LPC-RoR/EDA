class Carga < ApplicationRecord
	ESTADOS = ['ingreso', 'procesado']
	D_TABLA = {
		titulo:  true,
		tabs:    false,
		paginas: false,
		estados: true,
		nuevo:   true
	}
	TABLA_FIELDS = [
		['archivo', 'show'], 
		['nota',  'normal']
	]
	TIPO_NEW = 'sel_archivo_carga'

 	FORM_FIELDS = [
		['nota',    'entry'],
		['estado', 'hidden'],
		['archivo','hidden'],
	]
	has_many :publicaciones
end
