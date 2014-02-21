class OpinionsController < ApplicationController
	
	before_action :get_recipe, only: [:create]

	def get_recipe
		@recipe = Recipe.find(params[:recipe_id])
	end

	def new
		@opinion = Opinion.new
	end

	def create
		@opinion = @recipe.opinions.new(opinion_params)
		@opinion.user = current_user
		if @opinion.save
			@recipe.rating = @recipe.average_rate
			@recipe.save
			redirect_to recipe_path(@recipe)
		else
			redirect_to recipe_path(@recipe), :alert => "Error al comentar!"
		end
	end

	private

		def opinion_params
			params.require(:opinion).permit(:opinion, :rating)
		end
end
