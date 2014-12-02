class Recipe < ActiveRecord::Base
	include ActionView::Helpers::NumberHelper

	belongs_to :user
	belongs_to :difficulty
	belongs_to :course
	has_many :likes, dependent: :destroy
	has_many :links, dependent: :destroy
	has_many :steps, dependent: :destroy
	has_many :opinions, dependent: :destroy
	has_many :liked, :through => :likes, :source => :user

	accepts_nested_attributes_for :links, :allow_destroy => true
	accepts_nested_attributes_for :steps, :allow_destroy => true

	has_attached_file :photo, :styles => { :original => "1000x1000", :medium => "400x400>", :thumb => "100x100>" }, :default_url => "default_img_recipe_:style.png"
	validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
	validates_attachment :photo, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }

	logger = Log4r::Logger.new('recipe_model_debug')

	def self.find_proposals(idsIngredients)
		logger.info('Dentro do find_proposals')
		@proposals = Recipe.joins(:difficulty).joins(:links)
			.joins("join importances on links.importance_id = importances.id")
			.joins("left join likes on likes.recipe_id = recipes.id")
			.joins("left join opinions on opinions.recipe_id = recipes.id")
			.where(links: { ingredient_id: idsIngredients })
			.select("recipes.*, difficulties.description AS dif_desc, sum(importances.weight) as weight, count(likes.id) as numLikes, count(opinions.id) as numOpinions")
			.group("recipes.id, difficulties.id").order("weight desc")
	end

	def average_rate
		val = 0
		if opinions.count > 0
			opinions.each do |o|
				val += o.rating
			end
			val /= opinions.count
		end
		number_with_precision(val, precision: 1)
	end

	def rateRounded
		rating.round(1)
	end

	def celiac_desease
		links.each do |l|
			return true if l.ingredient.celiac
		end
		return false
	end
	
	def suitable_for_vegs
		links.each do |l|
			return false if l.ingredient.vegetarian
		end
		return true
	end

	def user_already_opined(user_op)
		opinions.each do |o|
			return o if o.user == user_op
		end
		return false
	end

	def photo_url
		photo.url(:medium)
	end
end
