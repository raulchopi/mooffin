class CoursesController < ApplicationController

  def index
    @courses = Course.all
    respond_to do |format|
      format.json {
        render json: @courses
      }
      format.html {
        @courses
      }
    end
  end

end
