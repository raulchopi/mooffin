class Course < ActiveRecord::Base
  has_many :recipes

  def initialize(course)
    @course = course
  end
end
