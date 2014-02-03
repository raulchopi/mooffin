class RecipesController < ApplicationController
	before_action :get_recipe, only: [:show]

	def get_recipe
		@recipe = Recipe.find(params[:id])
	end

	def new
		@recipe = Recipe.new
		@link = Link.new
		
		@ingredients = Ingredient.all
		respond_to do |format|
			format.json {
				render json: @ingredients
			}
		format.html {
			@ingredients
		}
		end
		@units = Unit.all
		respond_to do |format|
			format.json {
				render json: @units
			}
		format.html {
			@units
		}
		end
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

end
