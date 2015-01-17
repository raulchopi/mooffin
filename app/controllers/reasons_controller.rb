class ReasonsController < ApplicationController

  def index
    @reasons = Reason.all
    respond_to do |format|
      format.json {
        render json: @reasons
      }
      format.html {
        @reasons
      }
    end
  end

end
