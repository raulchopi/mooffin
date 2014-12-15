class RecipesController < ApplicationController
	before_action :get_recipe, only: [:show, :edit, :destroy]
	before_action :get_reasons, only: [:show]
	wrap_parameters format: [:json, :xml]

	logger = Log4r::Logger.new('recipes_controller_debug')

	def get_reasons
		@reasons = Reason.all
	end

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

	def update
		@recipe = current_user.recipes.update(params[:id], recipe_update_params)
		render :nothing => true, :status => 202
	end

	def destroy
		@recipe.destroy
	end

	def create
		@recipe = current_user.recipes.new(recipe_params)
		respond_to do |format|
			if @recipe.save
				format.html { redirect_to user_path(current_user), notice: 'Receta creada!' }
			else
				format.html { redirect_to new_recipe_path, :notice => "Error al crear la receta!" }
			end
		end
	end

	private
		def recipe_params
			params.require(:recipe).permit(:recipe, :description, :title, :time, :servings, :difficulty_id, :course_id,
				:photo, steps_attributes: [:orden, :description],
				links_attributes: [:ingredient_id, :importance_id, :unit_id, :number])
		end

		def recipe_update_params
			params.require(:recipe).permit(:recipe, :description, :title, :time, :servings, :difficulty_id, :course_id,
				:photo, steps_attributes: [:id, :orden, :description, :_destroy],
				links_attributes: [:id, :ingredient_id, :importance_id, :unit_id, :number, :_destroy])
		end

		def proposals_params
			params.require(:idsIngredients)
		end

end
