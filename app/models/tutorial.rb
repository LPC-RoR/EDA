class Tutorial < ApplicationRecord
	belongs_to :tema_ayuda

	has_many :pasos
end
