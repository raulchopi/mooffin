class Ingredient < ActiveRecord::Base
	has_many :links

	belongs_to :parent, :class_name => "Ingredient", :foreign_key => "parent_id"
	has_many :children, :class_name => "Ingredient", :foreign_key => "parent_id"

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
