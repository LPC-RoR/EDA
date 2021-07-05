class Proyecto < ApplicationRecord
	TABLA_FIELDS = [
		['proyecto', 'show'], 
		['sha1',     'normal']
	]

 	FORM_FIELDS = [
		['proyecto',           'entry'],
		['perfil_id',         'hidden'],
	]

	SHOW_FIELDS = [
		['email', 'normal'],
		['sha1',  'normal']
	]

	belongs_to :administrador, class_name: 'Perfil'

	has_many :cargas
	has_many :carpetas
	has_many :versiones
	has_many :etapas
	has_many :etiquetas
	has_many :reportes
	has_many :documentos
	has_many :caracterizaciones

	has_many :directorios

	has_many :coautores
	has_many :perfiles, through: :coautores

	has_many :asociaciones
	has_many :publicaciones, through: :asociaciones

	# Usada para List Selector
	def carpetas_seleccion
		self.carpetas.where(carpeta: Carpeta::NOT_MODIFY)
	end

	def carpetas_personalizadas
		self.carpetas.where.not(carpeta: Carpeta::NOT_MODIFY)
	end

	# Usada para List Selector
	def carpetas_proceso
		aceptadas_id = self.carpetas.find_by(carpeta: 'Aceptadas').id
		proceso_ids = self.carpetas.where.not(carpeta: Carpeta::NOT_MODIFY).ids
		ids_proceso = [aceptadas_id]
		
		Carpeta.where(id: ids_proceso.union(proceso_ids))
	end

	# Usudas para @carpetas_seleccion : Gestión de Carpetas
	def carpetas_origen
		self.carpetas.where(carpeta: ['Carga', 'Ingreso', 'Duplicadas'])
	end

	# Usudas para @carpetas_seleccion : Gestión de Carpetas
	def carpeta_origen(publicacion)
		if publicacion.duplicados.any?
			self.carpetas.find_by(carpeta: 'Duplicadas')
		elsif ['carga', 'WOS_bib'].include?(publicacion.origen)
			self.carpetas.find_by(carpeta: 'Carga')
		elsif publicacion.origen == 'ingreso'
			self.carpetas.find_by(carpeta: 'Ingreso')
		end
	end

	def carpetas_primer_destino
		self.carpetas.where(carpeta: ['Postergadas', 'Excluidas', 'Aceptadas'])
	end

	def carpetas_seleccionados_menos_activa_mas_origen(publicacion)
		nombre_carpetas = (['Postergadas', 'Excluidas', 'Aceptadas'] - [publicacion.carpetas.first.carpeta]) << carpeta_origen(publicacion).carpeta
		self.carpetas_seleccion.where(carpeta: nombre_carpetas)
	end

	def carpetas_todas_menos_activa_mas_origen(publicacion)
		carpetas_seleccion = ['Postergadas', 'Excluidas'] << carpeta_origen(publicacion).carpeta
		carpetas_personalizadas = self.carpetas.where.not(carpeta: Carpeta::NOT_MODIFY).map {|car| car.carpeta}
		self.carpetas.where(carpeta: carpetas_seleccion.union(carpetas_personalizadas))
	end

	def carpetas_de_proceso(publicacion)
		ids_personalizadas = self.carpetas.where.not(carpeta: Carpeta::NOT_MODIFY).ids
		id_aceptadas = self.carpetas.find_by(carpeta: 'Aceptadas')
		ids_personalizadas << id_aceptadas
		Carpeta.where(id: (ids_personalizadas - publicacion.carpetas.ids))
	end

	def temas_seleccion
		ids_temas = []
		carpetas = self.carpetas.where.not(carpeta: Carpeta::NOT_MODIFY)
		if carpetas.empty?
			Tema.where(tema: 'COLECCION VACÍA')
		else
			carpetas.each do |carpeta|
				ids_temas = ids_temas.union(carpeta.temas.empty? ? [] : carpeta.temas.ids)
			end
			Tema.where(id: ids_temas)
		end
	end

end
