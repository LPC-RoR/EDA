class Imagen < ApplicationRecord

	require 'carrierwave/orm/activerecord'

	TABLA_FIELDS = [
		['orden',      'normal'],
		['nota',       'normal'],
		['imagen',  'link_file']
	]

 	FORM_FIELDS = [
		['orden',              'entry'],
		['nota',               'entry'],
		['imagen',        'file_field'],
		['linea_id',          'hidden'],
		['directorio_id',     'hidden']
	]

	mount_uploader :imagen, ImagenUploader

	belongs_to :linea, optional: true
	belongs_to :directorio, optional: true
end
