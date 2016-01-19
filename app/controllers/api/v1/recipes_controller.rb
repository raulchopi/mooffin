# -*- encoding : utf-8 -*-
module Api
  module V1
    class RecipesController < ApiControllerBase

      def show
        @recipe = Recipe.find(params[:id])
        @recipe.increment!(:views_count, by = 1)	#-Contador de visitas
      end

    end
  end
end
