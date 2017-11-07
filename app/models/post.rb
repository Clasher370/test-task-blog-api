class Post < ApplicationRecord
  belongs_to :user
  has_many :ratings

  validates_presence_of :title, :content, :user_id
end
