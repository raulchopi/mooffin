class Unit < ActiveRecord::Base
	has_many :links

  def initialize(unit)
    @unit = unit
  end
end