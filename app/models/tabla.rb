class Tabla < ApplicationRecord

	require 'carrierwave/orm/activerecord'

	TABLA_FIELDS = [
		['orden',     'normal'],
		['tabla',       'show'],
		['archivo', 'link_file']
	]

	# -------------------- FORM  -----------------------
 	FORM_FIELDS = [
		['orden',        'entry'],
		['tabla',        'entry'],
		['archivo', 'file_field'],
		['padre_id',    'hidden'],
		['archivos', 'check_box'],
		['imagenes', 'check_box']
	]

	belongs_to :etapa, foreign_key: 'padre_id'

	has_many :encabezados

	has_many :lineas
	has_many :especificaciones
	has_many :observaciones

	mount_uploader :archivo, TablaUploader

end
