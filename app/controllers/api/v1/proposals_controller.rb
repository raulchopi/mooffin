# -*- encoding : utf-8 -*-
module Api
  module V1
    class ProposalsController < ApiControllerBase

      def index
        idsIngredients = []
    		idsIngredients = proposals_params
        @proposals = Recipe.find_proposals(idsIngredients)
      end

      private
        def proposals_params
          params.require(:idsIngredients)
        end

    end
  end
end
