# -*- encoding : utf-8 -*-
module Api
  module V1
    class ApiControllerBase < ApplicationController
      respond_to :json

      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

      private
        def record_not_found(error)
          render json: { error: error.message }, status: :not_found
        end
    end
  end
end
