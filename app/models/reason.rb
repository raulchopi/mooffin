class Reason < ActiveRecord::Base
  has_many :reports, dependent: :destroy
end
