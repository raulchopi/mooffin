class RecipesController < ApplicationController
	before_action :get_recipe

	def get_recipe
		@recipe = Recipe.find(params[:id])
	end

	def show
		@links 			= @recipe.links
		@steps			= @recipe.steps
	end
end
