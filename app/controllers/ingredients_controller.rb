class IngredientsController < ApplicationController

	def show
    @ingredient = Ingredient.find(params[:id])
  end

  def new
    @ingredient = Ingredient.new
  end

  def index
    @ingredients = Ingredient.all
    respond_to do |format|
      format.json {
        render json: @ingredients
      }
      format.html {
        @ingredients
      }
    end
  end

end
