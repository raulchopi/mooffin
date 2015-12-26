class CategoriesController < ApplicationController
  before_action :get_category, only: [:show, :getCategoryRecipes]
  wrap_parameters format: [:json, :xml]

  def get_category
		@category = Category.friendly.find(params[:id])
	end

  def show
    @recipes = @category.recipes
    respond_to do |format|
			format.json {
				render json: @recipes.to_json(:methods => [:photo_url])
			}
			format.html {
				@recipes
			}
			end
	end

  def index
    @categories = Category.all
    respond_to do |format|
      format.json {
        render json: @categories
      }
      format.html {
        @categories
      }
    end
  end

  def getCategoryRecipes
		@recipes = @category.recipes
		respond_to do |format|
			format.json {
				render json: @recipes.to_json(:methods => [:photo_url])
			}
			format.html {
				@recipes
			}
			end
	end

end
