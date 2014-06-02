class LikesController < ApplicationController

	before_action :get_recipe, only: [:create]
	before_action :get_like, only: [:destroy, :show]
	before_action :get_user, only: [:index]

	def get_recipe
		@recipe = Recipe.find(params[:recipe_id])
	end

	def get_like
		@like = Like.find(params[:id])
	end

	def get_user
		@user = User.find(params[:user_id])
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
