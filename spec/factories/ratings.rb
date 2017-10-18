FactoryGirl.define do
  factory :rating do
    post_rating { [*1..5].sample }
    rating_count { [*1..5].sample }
    post
  end
end
