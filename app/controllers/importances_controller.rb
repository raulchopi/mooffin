class ImportancesController < ApplicationController

	def index
		@importances = Importance.all
		respond_to do |format|
			format.json {
				render json: @importances
			}
			format.html {
				@importances
			}
		end
	end

end
