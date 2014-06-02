class Link < ActiveRecord::Base
	include ActionView::Helpers::NumberHelper
	
	belongs_to 	:recipe
	belongs_to 	:ingredient
	belongs_to 	:unit
	belongs_to 	:importance


	def unidadSinCeros
		number_with_precision(number, precision: 5, significant: true, strip_insignificant_zeros: true)
	end

end
