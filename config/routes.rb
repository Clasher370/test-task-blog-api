Rails.application.routes.draw do
  post 'create', to: 'posts#create'
  post 'rating', to: 'ratings#create'
end
