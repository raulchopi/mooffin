class ReceiptsController < ApplicationController

	def show
		@receipt = Receipt.find(params[:id])
	end

end
