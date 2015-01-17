class Report < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :user
  belongs_to :reason
end
