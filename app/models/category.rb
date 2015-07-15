class Category < ActiveRecord::Base
  has_many :recipecats, dependent: :destroy
end
