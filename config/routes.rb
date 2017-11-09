Rails.application.routes.draw do
  post 'create_post', to: 'posts#create'
  post 'rate_post', to: 'ratings#rate_post'
  get 'posts/top', to: 'posts#top_rated'
  get 'users/by_ip', to: 'users#by_ip'
end
