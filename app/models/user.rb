class User < ActiveRecord::Base
	
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_USERNAME = /\A[A-Za-z0-9_]+\z/

	before_validation :strip_and_downcase
 # before_validation :set_current_language, on: :create

  validates :username, presence: true, uniqueness: true, 
    format: { with: VALID_USERNAME }
  validates :email, presence: true, uniqueness: true, 
    format: { with: VALID_EMAIL_REGEX }
  validates_length_of :username, maximum: 32
  validates_length_of :email, in: 6..100

  has_many :authorizations
  has_many :opinions
	has_many :recipes
  has_many :likes

	def set_current_language
  	self.language = I18n.locale.to_s if self.language.blank?
  end

	def strip_and_downcase
    if username.present?
      username.strip!
      username.downcase!
    end

    if email.present?
      email.strip!
      email.downcase!
    end
  end

end
