class Receipt < ActiveRecord::Base
	belongs_to :user
	has_many :likes
	has_many :links
	has_many :steps
	has_many :opinions

end
