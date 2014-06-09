class User < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_USERNAME = /\A[A-Za-z0-9_]+\z/

  authenticates_with_sorcery!

  has_attached_file :avatar, :default_url => "default_img_user_:style.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_attachment :avatar, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }

  before_validation :strip_and_downcase
 # before_validation :set_current_language, on: :create

  validates :username, presence: true, uniqueness: true, 
    format: { with: VALID_USERNAME }
  validates :email, presence: true, uniqueness: true, 
    format: { with: VALID_EMAIL_REGEX }
  validates_length_of :username, maximum: 32
  validates_length_of :email, in: 6..100
  #validates :password, presence: true, confirmation: true, length: {minimum: 3}

  has_many :authorizations
  has_many :opinions, :dependent => :destroy
  has_many :recipes
  has_many :likes, :dependent => :destroy
  has_many :like_recipes, :through => :likes, :source => :recipes

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

  def self.create_with_omniauth(auth)  
    create! do |user|  
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.first_name
      user.surname = auth.info.last_name
      user.username = auth.uid
      user.email = auth.info.email
      user.avatar = auth.info.image
      #user.password = Devise.friendly_token[0,20]
    end  
  end 

  #Returns average rate of user's recipes (only 1 decimal)
  def average_rate_recipes
    val = 0
    if recipes.count > 0
      recipes.each do |r|
        val += r.rating
      end
      val /= recipes.count
    end
    number_with_precision(val, precision: 1)
  end

  #Returns average rate of user's liked recipes (only 1 decimal)
  def average_rate_likes
    val = 0
    if likes.count > 0
      likes.each do |l|
        val += l.recipe.rating
      end
      val /= likes.count
    end
    number_with_precision(val, precision: 1)
  end


end