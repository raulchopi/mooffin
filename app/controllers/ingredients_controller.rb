class IngredientsController < ApplicationController

	def ingredient_by_name
  		@ingredient = Ingredient.where(:name => params[:name])
	end

	def show
        @ingredient = Ingredient.find(params[:id])
    end

    def new
    	@ingredient = Ingredient.new
    end

end
