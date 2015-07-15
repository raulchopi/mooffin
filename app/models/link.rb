class Link < ActiveRecord::Base
	include ActionView::Helpers::NumberHelper

	belongs_to 	:recipe
	belongs_to 	:ingredient
	belongs_to 	:importance

end
