class LikesController < ApplicationController

	before_action :get_recipe, only: [:create]
	before_action :get_like, only: [:destroy, :show]

	def get_recipe
		@recipe = Recipe.find(params[:recipe_id])
	end

	def get_like
		@like = Like.find(params[:id])
	end	

	def index
		@likes = current_user.likes
	end

	def create
		@like = @recipe.likes.new()
		@like.user = current_user
		@like.save
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


end
