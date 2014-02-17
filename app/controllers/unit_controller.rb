class UnitController < ApplicationController

  def show
    @unit = Unit.find(params[:id])
  end

  def new
    @unit = Unit.new
  end

  def index
    @unit = Unit.all
    respond_to do |format|
      format.json {
        render json: @unit
      }
      format.html {
        @unit
      }
    end
  end
end