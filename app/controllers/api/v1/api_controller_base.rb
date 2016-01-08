# -*- encoding : utf-8 -*-
module Api
  module V1
    class ApiControllerBase < ApplicationController
      respond_to :json

      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

      before_filter :cors_preflight_check
      after_filter :cors_set_access_control_headers

      def cors_set_access_control_headers
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
        headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
        headers['Access-Control-Max-Age'] = "1728000"
      end

      def cors_preflight_check
        if request.method == 'OPTIONS'
          headers['Access-Control-Allow-Origin'] = '*'
          headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
          headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
          headers['Access-Control-Max-Age'] = '1728000'

          render :text => '', :content_type => 'text/plain'
        end
      end

      private
        def record_not_found(error)
          render json: { error: error.message }, status: :not_found
        end
    end
  end
end
