class Carga < ApplicationRecord

	require 'carrierwave/orm/activerecord'

	# ----------------------------------------- ESTADOS
	# SE define pero no se usa, el cambio se hace en código al procesar carga.
	ESTADOS = ['ingreso', 'procesada']

	# ----------------------------------------- CARGA
	# CARGA HACIA CARPETA
	# Carpeta destino
	CARPETA_CARGA = 'Revisar'

	# ----------------------------------------- HIDDEN CHILDS
	HIDDEN_CHILDS = ['procesos']

	# ------------------------------------- TABLA ------------------------------------------
	TABLA_FIELDS = [
		['archivo_carga', 'url'], 
		['status',     'normal'],
		['nota',       'normal']
	]

 	FORM_FIELDS = [
		['nota',               'entry'],
		['archivo_carga', 'file_field'],
		['estado',            'hidden'],
		['perfil_id',         'hidden'],
		['archivo',           'hidden']
	]

	## BOTNES EXTRA REGISTRO
	# [0] : Nombre del boton
	# [1] : link base, a esta base se le agrega el instancia_id
	# [2] : Si es true se agrega "objeto_id=#{@objeto.id}"
	X_BTNS = [
		['Proceso', '/cargas/', '/procesa_carga', false]
	]

	belongs_to :perfil

	has_many :procesos
	has_many :publicaciones, through: :procesos

	mount_uploader :archivo_carga, ArchivoCargaUploader

	def status
		"( #{self.n_procesados} : (N) #{self.n_nuevos} + (D) #{self.n_duplicados} + (V) #{self.n_vinculados} + (E) #{self.n_existentes} )"
	end

	def show_links
		[
			['Proceso', "/cargas/#{self.id}/procesa_carga"]
		]
		
	end

	def d_archivo
		self.archivo.split('/').last
	end

end
