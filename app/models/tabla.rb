class Tabla < ApplicationRecord

	require 'carrierwave/orm/activerecord'

	TABLA_FIELDS = [
		['orden',     'normal'],
		['tabla',       'show'],
		['archivo', 'link_file']
	]

	# -------------------- FORM DETAIL  -----------------------

	has_many :encabezados

	has_many :lineas
	has_many :documentos
	has_many :observaciones

	mount_uploader :archivo, TablaUploader

	def caracterizacion
		self.padre_class == 'Caracterizacion' ? Caracterizacion.find(self.padre_id) : nil
	end

	def etapa
		self.padre_class == 'Etapa' ? Etapa.find(self.padre_id) : nil
	end

end
