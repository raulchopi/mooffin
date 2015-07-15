class Category < ActiveRecord::Base
  extend FriendlyId
  
  friendly_id :slug_candidates, use: :slugged

  has_many :recipecats, dependent: :destroy

  def slug_candidates
    [
      :name,
      [:name, :description]
    ]
  end
end
