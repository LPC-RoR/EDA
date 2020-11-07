class Concepto < ApplicationRecord
	has_many :referencias

	has_many :padres, foreign_key: :categoria_id , class_name: "Agregacion"

	has_many :hijos, through: :padres

	has_many :hijos, foreign_key: :concepto_id, class_name: "Agregacion"

	has_many :padres, through: :hijos
end
