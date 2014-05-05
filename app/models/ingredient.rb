class Ingredient < ActiveRecord::Base
	has_many :links

	accepts_nested_attributes_for :links

	include ActiveModel::Conversion
	extend ActiveModel::Naming

	def initialize(ingredient)
		@ingredient = ingredient
	end

	def self.search(name)
		if ing 
			where('name LIKE ?', "%#{name}%")
		end
	end
end
