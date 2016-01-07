# -*- encoding : utf-8 -*-
module Api
  module V1
    class ProposalsController < ApiControllerBase

      def index
        ids = []
    		ids = proposals_params
        @proposals = Recipe.find_proposals(ids)
      end

      private
        def proposals_params
          params.require(:ids)
        end

    end
  end
end
