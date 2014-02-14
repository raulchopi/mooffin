class RecipesController < ApplicationController
	before_action :get_recipe, only: [:show]
	wrap_parameters format: [:json, :xml]

	def get_recipe
		@recipe = Recipe.find(params[:id])
	end

	def new
		@recipe = Recipe.new
		@link = Link.new		
	end

	def show
	end

	def index
		@recipes = Recipe.all
		respond_to do |format|
			format.json {
				render json: @recipes
			}
			format.html {
				@recipes
			}
  	end
	end

	def create
		@recipe = Recipe.new(recipe_params)
		@recipe.user_id = current_user.id
		@recipe.rating = 0
		@recipe.description = ""
		if @recipe.save
			redirect_to root_url
		else
			redirect_to new_recipe_path
		end
	end


	private
		def recipe_params
			params.require(:recipe).permit(:recipe, :title, :time, :servings, :difficulty_id, :description)
		end

end
