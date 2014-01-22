class RecipesController < ApplicationController
	before_action :get_recipe, only: [:show]

	def get_recipe
		@recipe = Recipe.find(params[:id])
	end

	def new
		@recipe = Recipe.new
	end

	def show
	end
end
