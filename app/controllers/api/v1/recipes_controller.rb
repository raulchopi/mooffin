# -*- encoding : utf-8 -*-
module Api
  module V1
    class RecipesController < ApiControllerBase

      def show
    		@recipe = Recipe.find(params[:id])
    	end

    end
  end
end
