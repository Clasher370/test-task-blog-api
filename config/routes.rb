Rails.application.routes.draw do
  post 'create_post', to: 'posts#create'
  post 'rate_post', to: 'ratings#rate_or_create'
  post 'top_posts', to: 'posts#top_rated'
  get 'ips', to: 'posts#ip_with_more_when_one_users'
end
