class Carga < ApplicationRecord

	require 'carrierwave/orm/activerecord'

	# ----------------------------------------- ESTADOS
	# SE define pero no se usa, el cambio se hace en código al procesar carga.
	ESTADOS = ['ingreso', 'procesada']

	# ------------------------------------- TABLA ------------------------------------------
	TABLA_FIELDS = [
		['archivo_carga', 'url'], 
		['status',     'normal'],
		['d_n',         'valor'],
		['nota',       'normal'],
		['estado',     'normal']
	]

 	FORM_FIELDS = [
		['nota',               'entry'],
		['archivo_carga', 'file_field'],
		['refill',         'check_box'],
		['estado',            'hidden'],
		['proyecto_id',       'hidden'],
		['archivo',           'hidden']
	]

	belongs_to :proyecto

	has_many :procesos
	has_many :publicaciones, through: :procesos

	mount_uploader :archivo_carga, ArchivoCargaUploader

	def status
		self.n_procesados.blank? ? '[ sin procesar ]' : "[ #{self.n_procesados} | N:#{self.n_nuevos} + D:#{self.n_duplicados} + V:#{self.n_vinculados} + E:#{self.n_existentes} ]"
	end

	def d_n
		self.publicaciones.count
	end

end
