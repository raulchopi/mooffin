class Opinion < ActiveRecord::Base
	belongs_to :recipe
	belongs_to :user

	def self.find_recipeopinions(recipeId)
		logger.info('Dentro do find_recipeopinions')

		@opinions = Opinion.joins(:user)
			.where(opinions: { recipe_id: recipeId })
			.where.not(opinions: {opinion: ''}) #No se muestran las que no tengan texto
			.select("users.*, opinions.*")
	end

	def opinion_user_avatar_url
		user.avatar.url(:original)
	end

end
