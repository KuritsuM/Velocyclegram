Rails.application.routes.draw do
  resources :likes, only: [:create, :destroy]
  resources :commentaries, only: [:destroy, :create, :edit, :update]
  resources :follow, only: [ :create, :destroy ]
  resources :posts, only: [ :create, :show, :update, :destroy, :new, :edit ]
  #resources :user, only: [ :update, :edit, :destroy ]
  devise_for :users

  root "application#index"
  get "/profile/:id", to: "velocyclegram#profile", as: 'profile'

  get "/followers/:id", to: "follow#followers", as: 'followers'
  get "/followings/:id", to: "follow#followings", as: 'followings'
=begin
  post "/follow", to: "follow#create"
  delete "/follow/:id", to: "follow#destroy"
=end
  get "/user/:page", to: "users#show", as: 'users'
  get "/user/:id/edit", to: "users#edit", as: 'edit_user'
  patch "/user/:id", to: "users#update"
  put "/user/:id", to: "users#update"
  delete "/user/:id", to: "users#destroy", as: 'user'

  get "/commentary/:post_id", to: "commentaries#new", as: "new_comment"
end
