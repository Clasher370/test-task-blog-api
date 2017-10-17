Rails.application.routes.draw do
  post 'create', to: 'posts#create'
  post 'rating', to: 'ratings#create'
  post 'top_post', to: 'posts#top_rated'
  get 'ips', to: 'posts#ip_with_more_when_one_users'
end
