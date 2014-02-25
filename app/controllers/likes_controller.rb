class LikesController < ApplicationController

	def index
		@likes = current_user.likes
	end

	def create
		@like = current_user.likes.new(like_params)
		@like.save
		respond_to do |format|
			format.js
		end
	end

	private

		def like_params
			params.require(:like).permit(:recipe)
		end

end
