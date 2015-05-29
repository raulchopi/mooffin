class LikesController < ApplicationController

	before_action :get_recipe, only: [:create]
	before_action :get_like, only: [:destroy, :show]
	before_action :get_user, only: [:index]

	wrap_parameters format: [:json, :xml]

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

	def getUserRecipeLike
		@like = Like.find_by user_id: current_user.id, recipe_id: userrecipelike_params
		respond_to do |format|
			format.json {
				render json: @like
			}
			format.html {
				@like
			}
			end
	end

	def create
		@like = @recipe.likes.new()
		@like.user = current_user
		@like.save
		respond_to do |format|
			format.js
			format.json {
				render json: @like
			}
			format.html {
				@like
			}
		end
	end

	def destroy
		@like.destroy
		respond_to do |format|
			format.js
			format.json {
				render json: @like
			}
			format.html {
				@like
			}
		end
	end

	private
		def userrecipelike_params
			params.require(:recipeId)
		end


end
