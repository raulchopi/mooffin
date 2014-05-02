class Importance < ActiveRecord::Base
	has_many :links

	def initialize(importance)
		@importance = importance
	end
end
