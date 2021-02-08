class Proyecto < ApplicationRecord
	TABLA_FIELDS = [
		['proyecto', 'show'], 
		['sha1',   'normal']
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

	has_many :coautores
	has_many :perfiles, through: :coautores

	has_many :herencias
	has_many :temas, through: :herencias

	has_many :versiones
	has_many :etapas
end
