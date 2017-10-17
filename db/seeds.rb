# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users_id = []
10.times do
  user = User.create!(login: Faker::Internet.user_name)
  users_id << user.id
end

user_ip = []
5.times do
  user_ip << Faker::Internet.ip_v4_address
end

posts = []
100.times do
  post = Post.create!(title: Faker::Lorem.word, content: Faker::Lorem.sentence,  user_id: users_id.sample, ip: user_ip.sample)
  posts << post.id
end

random_posts = posts.sample(20)
20.times do |i|
  Rating.create!(post_rating: [*1..5].sample, post_id: random_posts[i])
end
