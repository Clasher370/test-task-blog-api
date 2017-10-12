class Post < ApplicationRecord
  belongs_to :user
  has_one :ratings
end
