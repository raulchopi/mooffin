class UnitsController < ApplicationController

  def show
    @unit = Unit.find(params[:id])
  end

  def new
    @unit = Unit.new
  end

  def index
    @units = Unit.all
    respond_to do |format|
      format.json {
        render json: @units
      }
      format.html {
        @units
      }
    end
  end
end