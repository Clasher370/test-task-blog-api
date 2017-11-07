class Post < ApplicationRecord
  belongs_to :user
  has_many :ratings

  validates_presence_of :title, :content, :user_id

  def self.average_rating
    select(:id, 'AVG(ratings.rate) rating').joins(:ratings).group('posts.id')
  end
end
