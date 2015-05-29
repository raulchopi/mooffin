# -*- encoding : utf-8 -*-
module Api
  module V1
    class LikesController < ApiControllerBase

      def show
        @likes = User.find(params[:id]).likes
      end

    end
  end
end
