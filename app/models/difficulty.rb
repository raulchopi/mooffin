class Difficulty < ActiveRecord::Base
	has_many :recipes

	def initialize(difficulty)
		@difficulty = difficulty
	end
end
