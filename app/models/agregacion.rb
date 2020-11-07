class Agregacion < ApplicationRecord
	belongs_to :padres, class_name: 'Concepto'
	belongs_to :hijos, class_name: 'Concepto'
end
