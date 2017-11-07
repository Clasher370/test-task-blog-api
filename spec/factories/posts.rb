FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.word }
    content { Faker::Lorem.sentence(3) }
    ip { Faker::Internet.ip_v4_address }
    user

    factory :post_with_rating do
      transient do
        rating 5
      end

      after(:create) do |post, evaluator|
        create(:rating, post: post, rate: evaluator.rating)
      end
    end
  end
end
