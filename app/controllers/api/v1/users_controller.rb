# -*- encoding : utf-8 -*-
module Api
  module V1
    class UsersController < ApiControllerBase

      def getUserByUid
        @user = User.find_by_uid(params[:uid])
      end

    end
  end
end
