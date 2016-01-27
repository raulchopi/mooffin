# -*- encoding : utf-8 -*-
module Api
  module V1
    class UsersController < ApiControllerBase

      def getUserByUid
        @user = User.find_by_uid(auth_params[:auth][:uid]) || User.create_with_omniauth(auth_params)
      end

      def getUserFavRecipes
        @favs = User.find(params[:id]).likes
      end

      def getUserRecipes
        @recipes = User.find(params[:id]).recipes
      end

      private
    		def auth_params
    			params.require(:auth).permit(:name, :surname, :username, :gender, :email, :uid, :avatar, :profile)
    		end

    end
  end
end
