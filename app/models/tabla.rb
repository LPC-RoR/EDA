class Tabla < ApplicationRecord

	require 'carrierwave/orm/activerecord'

	TABLA_FIELDS = [
		['orden',     'normal'],
		['tabla',       'show']
	]

	# -------------------- FORM  -----------------------
 	FORM_FIELDS = [
		['orden',        'entry'],
		['tabla',        'entry'],
		['archivo', 'file_field'],
		['padre_id',    'hidden']
	]

	belongs_to :etapa, foreign_key: 'padre_id'

	has_one :encabezado

	has_many :lineas
	has_many :especificaciones
	has_many :observaciones

	mount_uploader :archivo, TablaUploader

end
