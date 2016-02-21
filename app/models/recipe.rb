class Recipe < ActiveRecord::Base
	include ActionView::Helpers::NumberHelper
	extend FriendlyId

	friendly_id :slug_candidates, use: :slugged

	belongs_to :user
	belongs_to :difficulty
	belongs_to :course
	has_many :likes, dependent: :destroy
	has_many :links, dependent: :destroy
	has_many :steps, dependent: :destroy
	has_many :opinions, dependent: :destroy
	has_many :reports, dependent: :destroy
	has_many :recipecats, dependent: :destroy
	has_many :categories, :through => :recipecats
	has_many :liked, :through => :likes, :source => :user

	accepts_nested_attributes_for :links, :allow_destroy => true
	accepts_nested_attributes_for :steps, :allow_destroy => true
	accepts_nested_attributes_for :recipecats, :allow_destroy => true

	has_attached_file :photo, :styles => { :original => "1000x1000", :medium => "400x400>", :thumb => "100x100>" }, :default_url => "default_img_recipe_:style.png"
	validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
	validates_attachment :photo, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }

	logger = Log4r::Logger.new('recipe_model_debug')

	# Try building a slug based on the following fields in
  # increasing order of specificity.
  def slug_candidates
    [
      :title,
      [:title, :user_id]
    ]
  end

	# Buscamos recetas con ingrediente + recetas 'hermanas' + recetas 'padre' + recetas 'hijas'
	def self.find_proposals(idsIngredients)
		logger.info('Dentro do find_proposals')

		@proposals = Recipe.find_by_sql ["SELECT recipes.*,
			difficulties.description AS dif_desc,
			sum(importances.weight) as weight,
			rt.likes as num_likes,
			rt.opinions as num_opinions
			FROM recipes
			INNER JOIN difficulties ON difficulties.id = recipes.difficulty_id
			INNER JOIN links ON links.recipe_id = recipes.id
			inner join ingredients ON ingredients.id = links.ingredient_id
			join importances on links.importance_id = importances.id
			join vw_recipe_totals rt on rt.recipe_id = recipes.id
			WHERE ingredients.id IN (?)
			GROUP BY recipes.id, difficulties.id, rt.likes, rt.opinions

			UNION
			SELECT recipes.*,
			difficulties.description AS dif_desc,
			sum(importances.weight*0.75) as weight,
			rt.likes as num_likes,
			rt.opinions as num_opinions
			FROM recipes
			INNER JOIN difficulties ON difficulties.id = recipes.difficulty_id
			INNER JOIN links ON links.recipe_id = recipes.id
			inner join ingredients ON ingredients.id = links.ingredient_id
			join importances on links.importance_id = importances.id
			join vw_recipe_totals rt on rt.recipe_id = recipes.id
			WHERE ingredients.id NOT IN (?)
			AND ingredients.parent_id IN (select parent_id from ingredients WHERE id in (?))
			GROUP BY recipes.id, difficulties.id, rt.likes, rt.opinions

			UNION
			SELECT recipes.*,
			difficulties.description AS dif_desc,
			sum(importances.weight*0.75) as weight,
			rt.likes as num_likes,
			rt.opinions as num_opinions
			FROM recipes
			INNER JOIN difficulties ON difficulties.id = recipes.difficulty_id
			INNER JOIN links ON links.recipe_id = recipes.id
			inner join ingredients ON ingredients.id = links.ingredient_id
			join importances on links.importance_id = importances.id
			join vw_recipe_totals rt on rt.recipe_id = recipes.id
			WHERE ingredients.id NOT IN (?)
			AND ingredients.id IN (select parent_id from ingredients WHERE id in (?))
			GROUP BY recipes.id, difficulties.id, rt.likes, rt.opinions

			UNION
			SELECT recipes.*,
			difficulties.description AS dif_desc,
			sum(importances.weight*0.75) as weight,
			rt.likes as num_likes,
			rt.opinions as num_opinions
			FROM recipes
			INNER JOIN difficulties ON difficulties.id = recipes.difficulty_id
			INNER JOIN links ON links.recipe_id = recipes.id
			inner join ingredients ON ingredients.id = links.ingredient_id
			join importances on links.importance_id = importances.id
			join vw_recipe_totals rt on rt.recipe_id = recipes.id
			WHERE ingredients.id NOT IN (?)
			AND ingredients.parent_id IN (select id from ingredients WHERE id in (?))
			GROUP BY recipes.id, difficulties.id, rt.likes, rt.opinions

			ORDER BY weight desc, num_likes desc, views_count desc",
			idsIngredients, idsIngredients, idsIngredients, idsIngredients, idsIngredients, idsIngredients, idsIngredients]
	end

	def self.searchByName(name)
		@recipes = Recipe.find_by_sql ["SELECT recipes.*
			FROM recipes WHERE lower_unaccent(recipes.title) LIKE ?", "%#{name.downcase}%"]
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

	def user_already_reported(user_report)
		reports.each do |r|
			return true if r.user == user_report
		end
		return false
	end

	def photo_url
		photo.url(:medium)
	end

	def self.update_sitemap
		system("RAILS_ENV=#{Rails.env} bundle exec rake sitemap:generate")
		system("RAILS_ENV=#{Rails.env} bundle exec rake sitemap:symlink")
	end

end
