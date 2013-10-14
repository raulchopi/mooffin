class Opinion < ActiveRecord::Base
	belongs_to :receipt
	belongs_to :user
end
