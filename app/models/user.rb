class User < ActiveRecord::Base
	
	before_validation :strip_and_downcase_username
  before_validation :set_current_language, :on => :create

  validates :username, :presence => true, :uniqueness => true
  validates_format_of :username, :with => /\A[A-Za-z0-9_]+\z/
  validates_length_of :username, :maximum => 32

  has_many :authorization

	has_many :opinions
	has_many :recipes
	has_many :likes

	def set_current_language
  	self.language = I18n.locale.to_s if self.language.blank?
  end

	def strip_and_downcase_username
    if username.present?
      username.strip!
      username.downcase!
    end
  end

end
