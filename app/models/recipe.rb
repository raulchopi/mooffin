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
			.where(links: { ingredient_id: idsIngredients })
			.select("recipes.*, difficulties.description AS dif_desc").distinct

			#select r.id receta, r.title titulo, l.ingredient_id ingrediente, temp.peso
			#from
			#(select l.id, l.ingredient_id ingredient_id, sum(l.importance_id) peso
			#from links l
			#where l.ingredient_id in (348)
			#group by l.id, l.ingredient_id) temp
			#join links l on l.id = temp.id
			#join recipes r on r.id = l.recipe_id
			#order by 3 desc;
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
