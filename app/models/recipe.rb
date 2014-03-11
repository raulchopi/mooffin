class Recipe < ActiveRecord::Base
	belongs_to :user
	belongs_to :difficulty
	has_many :likes, dependent: :destroy
	has_many :links, dependent: :destroy
	has_many :steps, dependent: :destroy
	has_many :opinions, dependent: :destroy
	has_many :liked, :through => :likes, :source => :user

	accepts_nested_attributes_for :links, :steps

	has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }

	def average_rate
		val = 0
		if opinions.count > 0
			opinions.each do |o|
				val += o.rating
			end
			val /= opinions.count
		end
		val
	end

	def rateRounded
		rating.round(1)
	end

	def celiacDesease
		links.each do |l|
			return true if l.ingredient.celiac
		end
		return false
	end
end
