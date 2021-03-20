class Imagen < ApplicationRecord

	require 'carrierwave/orm/activerecord'

	TABLA_FIELDS = [
		['orden',      'normal'],
		['imagen',  'link_file'], 
		['nota',       'normal']
	]

 	FORM_FIELDS = [
		['orden',              'entry'],
		['nota',               'entry'],
		['imagen',        'file_field'],
		['linea_id',          'hidden'],
	]

	mount_uploader :imagen, ImagenUploader

	belongs_to :linea
end