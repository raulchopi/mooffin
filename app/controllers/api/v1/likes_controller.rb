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

      def doLike
    		@like = Recipe.find(userLike_params[:recipeId]).likes.new()
    		@like.user = User.find(userLike_params[:userId])
    		@like.save
    	end

      def dontLike
        @like = Like.find_by user_id: userLike_params[:userId], recipe_id: userLike_params[:recipeId]
    		@like.destroy
    	end

      private
    		def userLike_params
    			params.require(:userId, :recipeId)
    		end
    end
  end
end
