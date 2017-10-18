class Rating < ApplicationRecord
  belongs_to :post

  before_create :set_rating_count

  validates_uniqueness_of :post_id

  private

  def set_rating_count
    self.rating_count ||= 1
  end
end
