# -*- encoding : utf-8 -*-
module Api
  module V1
    class ProposalsController < ApiControllerBase

      def index
        @proposals = Recipe.find_proposals(params[:ids].split(','))
      end

    end
  end
end
