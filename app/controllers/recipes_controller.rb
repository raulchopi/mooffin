class RecipesController < ApplicationController
	before_action :get_recipe, only: [:show, :edit, :destroy]
	wrap_parameters format: [:json, :xml]

	def get_recipe
		@recipe = Recipe.find(params[:id])
	end

	def new
		@recipe = Recipe.new
		@link = Link.new
	end

	def show
		@opinion = Opinion.new
		@opinions = @recipe.opinions
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

	def edit
	end

	def destroy 
		@recipe.destroy
		redirect_to user_path(current_user.id)
	end

	def create
		@recipe = current_user.recipes.new(recipe_params)
		@recipe.rating = 0
		@recipe.description = ''
		if @recipe.save
			redirect_to root_url
		else
			redirect_to new_recipe_path
		end
	end


	private
		def recipe_params
			params.require(:recipe).permit(:recipe, :title, :time, :servings, :difficulty_id, :description, steps_attributes: [:orden, :description], links_attributes: [:ingredient_id, :importance_id, :unit_id, :number])
		end

end
