class Campo < ApplicationRecord
	TABLA_FIELDS = [
		['orden',     'normal'], 
		['campo',     'normal'],
		['d_cursiva', 'normal'],
		['d_negrita', 'normal'],
		['d_dot',     'normal']
	]

 	FORM_FIELDS = [
		['orden',                'entry'],
		['campo',                'entry'],
		['cursiva',          'check_box'],
		['negrita',          'check_box'],
		['dot',              'check_box'],
		['tipo_publicacion_id', 'hidden'],
		['formato_id',          'hidden']
	]

	belongs_to :tipo_publicacion, optional: true
	belongs_to :perfil, optional: true

	def d_cursiva
		self.cursiva ? 'cursiva' : 'normal'
	end

	def d_negrita
		self.negrita ? 'negrita' : 'normal'
	end

	def d_dot
		self.dot ? 'dot' : ''
	end

end
