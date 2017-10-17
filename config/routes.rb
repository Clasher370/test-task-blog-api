Rails.application.routes.draw do
  post 'create', to: 'posts#create'
  post 'rating', to: 'ratings#create'
  post 'top_post', to: 'posts#top_rated'
end
