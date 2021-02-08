class Version < ApplicationRecord

	require 'carrierwave/orm/activerecord'

	TABLA_FIELDS = [
		['version',  'link_file'],
		['nota',        'normal']
	]

	# -------------------- FORM  -----------------------
 	FORM_FIELDS = [
		['nota',         'entry'],
		['version', 'file_field'],
		['estado',      'hidden'],
		['proyecto_id', 'hidden']
	]

	belongs_to :proyecto

	mount_uploader :version, VersionUploader
end
