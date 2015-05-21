# -*- encoding : utf-8 -*-
module Api
  module V1
    class IngredientsController < ApiControllerBase

      def index
        @ingredients = Ingredient.all
      end

    end
  end
end
