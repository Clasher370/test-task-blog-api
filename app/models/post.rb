class Post < ApplicationRecord
  belongs_to :user
  has_many :ratings

  validates_presence_of :title, :content, :user_id

  def self.average_rating
    select(:id, :title, :content, 'AVG(ratings.rate) rating')
        .left_outer_joins(:ratings)
        .group('posts.id')
        .order('rating DESC NULLS LAST')
  end
end
