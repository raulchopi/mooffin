class DifficultiesController < ApplicationController

	def index
		@difficulties = Difficulty.all
		respond_to do |format|
			format.json {
				render json: @difficulties
			}
			format.html {
				@difficulties
			}
		end
	end

end
