class Proyecto < ApplicationRecord
	TABLA_FIELDS = [
		['proyecto', 'normal'], 
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

	has_many :coautores
	has_many :perfiles, through: :coautores

	has_many :herencias
	has_many :temas, through: :herencias

	has_many :asociaciones
	has_many :publicaciones, through: :asociaciones

end
