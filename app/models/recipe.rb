class Recipe < ActiveRecord::Base
	belongs_to :user
	belongs_to :difficulty
	has_many :likes, dependent: :destroy
	has_many :links, dependent: :destroy
	has_many :steps, dependent: :destroy
	has_many :opinions, dependent: :destroy

	accepts_nested_attributes_for :links, :steps

	has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
