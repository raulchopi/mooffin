# -*- encoding : utf-8 -*-
module Api
  module V1
    class RecipesController < ApiControllerBase

      def show
    		@recipe = Recipe.friendly.find(params[:id])
    	end

    end
  end
end
