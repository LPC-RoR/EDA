class Recurso < ApplicationRecord
	# LOS MODELOS DE CONTROLADORES CON FRAME TIENEN EL TITULO EN EL MODELO
	FRAME_TITULO = {
		'index'      => 'Colecciones',
		'escritorio' => 'Escritorio'
	}

	FRAME_ACTIONS_TYPE = {
		'index'      => 'tabla',
		'escritorio' => 'tabla'
#		'parametros' => 'valor'
	}
end
