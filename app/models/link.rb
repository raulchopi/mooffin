class Link < ActiveRecord::Base
	belongs_to :receipt
	belongs_to :ingredient
end
