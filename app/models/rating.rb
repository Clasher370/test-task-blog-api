class Rating < ApplicationRecord
  belongs_to :post
  validate :rating_diapason

  private

  def rating_diapason
    errors.add(:rate, 'value must be from 1 to 5') unless [*1..5].include? rate
  end
end
