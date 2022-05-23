Rails.application.routes.draw do
  resources :likes, only: [:create, :destroy]
  resources :commentaries, only: [:destroy, :create, :edit, :update]
  resources :posts
  devise_for :users

  root "application#index"
  get "/profile/:id", to: "velocyclegram#profile", as: 'profile'

  get "/followers/:id", to: "follow#followers", as: 'followers'
  get "/followings/:id", to: "follow#followings", as: 'followings'
  post "/follow", to: "follow#create"
  delete "/unfollow", to: "follow#delete"

  get "/commentary/:post_id", to: "commentaries#new", as: "new_comment"
end
