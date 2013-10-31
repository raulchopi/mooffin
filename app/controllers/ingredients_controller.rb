class IngredientsController < ApplicationController

	def show
    @ingredient = Ingredient.find(params[:id])
  end

  def new
    @ingredient = Ingredient.new
  end

  def index
  	@ingredient = Ingredient.search(params[:name])
  	
    respond_to do |format|
      format.html # index.html.erb      		
    end
  end
end
