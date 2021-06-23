class Archivo < ApplicationRecord

	require 'carrierwave/orm/activerecord'

	TABLA_FIELDS = [
		['archivo', 'link_file'],
		['nota',       'normal'],
		['d_fecha',   'diahora']
	]

 	FORM_FIELDS = [
		['nota',               'entry'],
		['archivo',       'file_field'],
		['linea_id',          'hidden'],
		['directorio_id',     'hidden'],
		['documento_id',      'hidden']
	]

	mount_uploader :archivo, ArchivoUploader

	belongs_to :linea, optional: true
	belongs_to :directorio, optional: true
	belongs_to :documento, optional: true

	def d_fecha
		self.created_at
	end
end
