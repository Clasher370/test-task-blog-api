FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.word }
    content { Faker::Lorem.sentence(3) }
    ip { Faker::Internet.ip_v4_address }
    user
  end
end
