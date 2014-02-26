class LikesController < ApplicationController

	before_action :get_recipe, only: [:create]
	before_action :get_like, only: [:destroy, :show]

	def get_recipe
		@recipe = Recipe.find(params[:recipe_id])
	end

	def get_like
		@like = Like.find_by_user_id_and_recipe_id(current_user, params[:recipe_id])
	end	

	def index
		@likes = current_user.likes
	end

	def show
	end

	def create
		@like = current_user.likes.create(@recipe)
		respond_to do |format|
			format.js
		end
	end

	def destroy 
		@like.destroy
		respond_to do |format|
			format.js
		end
	end

	private

		def like_params
			params.require(:user)
		end

end
