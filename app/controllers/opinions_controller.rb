class OpinionsController < ApplicationController

	before_action :get_recipe, only: [:create]
	before_action :get_opinion, only: [:destroy]

	def get_recipe
		@recipe = Recipe.find(params[:recipe_id])
	end

	def get_opinion
		@opinion = Opinion.find(params[:id])
	end

	def index
		@opinions = Opinion.all
		respond_to do |format|
			format.json {
				render json: @opinions
			}
			format.html {
				@opinions
			}
			end
	end

	def create
		@opinion = @recipe.opinions.new(opinion_params)
		@opinion.user = current_user
		if @opinion.save
			@recipe.rating = @recipe.average_rate
			@recipe.save
		else
			redirect_to recipe_path(@recipe), :alert => "Error al comentar!"
		end
		respond_to do |format|
			format.json { render json: @recipe }
			format.js
		end
	end

	def destroy
		@opinion.destroy
		@opinion.recipe.rating = @opinion.recipe.average_rate
		@opinion.recipe.save
		respond_to do |format|
			format.js
		end
	end

	def recipeopinions
		logger.info('opinions_params:' + recipeopinions_params)
		@recipe = Recipe.find(recipeopinions_params)
		@opinions = @recipe.opinions
		respond_to do |format|
			format.json {
				render json: @opinions
			}
			format.html {
				@opinions
			}
			end
	end


	private

		def opinion_params
			params.require(:opinion).permit(:opinion, :rating)
		end

		def recipeopinions_params
			params.require(:recipeId)
		end
end
