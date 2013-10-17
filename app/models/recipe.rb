class Recipe < ActiveRecord::Base
	belongs_to :user
	has_many :likes
	has_many :links
	has_many :steps
	has_many :opinions
	has_attached_file :photo => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => ""
end
