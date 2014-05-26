class RecipesController < ApplicationController
	before_action :get_recipe, only: [:show, :edit, :destroy]
	wrap_parameters format: [:json, :xml]

	logger = Log4r::Logger.new('recipes_controller_debug')

	def get_recipe
		@recipe = Recipe.find(params[:id])
	end

	def new
		@recipe = Recipe.new
		@link = Link.new
	end

	def show
		@opinion = Opinion.new
		@like = Like.new
		@opinions = @recipe.opinions
		@recipe.increment!(:views_count, by = 1)	#-Contador de visitas
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

	def proposals
		logger.info('idsIngredients:' + proposals_params)
		idsIngredients = []
		idsIngredients = eval(proposals_params)
		@proposals = Recipe.find_proposals(idsIngredients)
		respond_to do |format|
			format.json {
				render json: @proposals.to_json(:methods => [:photo_url])
			}
			format.html {
				@proposals
			}
  	end
	end

	def edit
	end

	def destroy 
		@recipe.destroy
	end

	def create
		@recipe = current_user.recipes.new(recipe_params)
		if @recipe.save
			redirect_to new_recipe_path, :notice => "Receta creada!"  
		else
			redirect_to new_recipe_path, :notice => "Error al crear la receta!"  
		end
	end

	private
		def recipe_params
			params.require(:recipe).permit(:recipe, :title, :time, :servings, :difficulty_id, 
				:photo, :description, steps_attributes: [:orden, :description], 
				links_attributes: [:ingredient_id, :importance_id, :unit_id, :number])
		end

		def proposals_params
			params.require(:idsIngredients)
		end

end
