class Ingreso < ApplicationRecord
	# LOS MODELOS DE CONTROLADORES CON FRAME TIENEN EL TITULO EN EL MODELO
	FRAME_TITULO = {
		'index'      => 'Ingresos'
	}

	FRAME_TABS = {
		'index' => ['ingreso', 'duplicado', 'papelera']
	}

	FRAME_ACTIONS_TYPE = {
		'index'     => 'tabla'
#		'parametros' => 'valor'
	}
end
