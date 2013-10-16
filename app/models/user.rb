class User < ActiveRecord::Base
	has_many :opinions
	has_many :recipes
	has_many :likes
end
