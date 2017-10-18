# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
logins = []
100.times { logins << Faker::Internet.user_name }
ips = []
50.times { ips << Faker::Internet.ip_v4_address }

200000.times do
  PostCreate.new(login: logins.sample,
             ip: ips.sample,
             title: Faker::Lorem.word,
             content: Faker::Lorem.sentence(3)).create
end

posts_id = Post.limit(500).pluck(:id)
rating = [*1..5]

500.times do
  RatePost.new(posts_id.sample, rating.sample).get_rating
end
