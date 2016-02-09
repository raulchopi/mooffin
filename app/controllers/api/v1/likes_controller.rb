# -*- encoding : utf-8 -*-
module Api
  module V1
    class LikesController < ApiControllerBase

      def show
        @likes = User.find(params[:id]).likes
      end

      def userLikesRecipe
        @like = Like.find_by user_id: params[:userId], recipe_id: params[:recipeId]
      end

    end
  end
end
