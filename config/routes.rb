Rails.application.routes.draw do
  resources :likes, only: [:create, :destroy]
  resources :commentaries, only: [:destroy, :create, :edit, :update]
  resources :follow, only: [ :create, :destroy ]
  resources :posts
  devise_for :users

  root "application#index"
  get "/profile/:id", to: "velocyclegram#profile", as: 'profile'

  get "/followers/:id", to: "follow#followers", as: 'followers'
  get "/followings/:id", to: "follow#followings", as: 'followings'
=begin
  post "/follow", to: "follow#create"
  delete "/follow/:id", to: "follow#destroy"
=end
  get "/users/:page", to: "users#show", as: 'users'

  get "/commentary/:post_id", to: "commentaries#new", as: "new_comment"
end
