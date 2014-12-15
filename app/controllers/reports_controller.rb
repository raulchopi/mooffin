class ReportsController < ApplicationController

  before_action :get_recipe, only: [:create]

  def get_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def create
    @report = @recipe.reports.new(report_params)
    @report.user = current_user
    if @report.save
      #accion al guardar
    else
      redirect_to recipe_path(@recipe), :alert => "Error al comentar!"
    end
    respond_to do |format|
      format.json { render json: @recipe }
      format.js
    end
  end


  private

    def report_params
      params.require(:report).permit(:description, :reason_id)
    end

end
