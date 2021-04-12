class Archivo < ApplicationRecord

	require 'carrierwave/orm/activerecord'

	TABLA_FIELDS = [
		['orden',      'normal'],
		['nota',       'normal'],
		['archivo', 'link_file']
	]

 	FORM_FIELDS = [
		['orden',              'entry'],
		['nota',               'entry'],
		['archivo',       'file_field'],
		['linea_id',          'hidden'],
		['directorio_id',     'hidden']
	]

	mount_uploader :archivo, ArchivoUploader

	belongs_to :linea, optional: true
	belongs_to :directorio, optional: true
end
