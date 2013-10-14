class User < ActiveRecord::Base
	has_many :opinions
	has_many :receipts
	has_many :likes
end
