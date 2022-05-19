Rails.application.routes.draw do
  devise_for :users

  root "application#index"
  get "/profile/:id", to: "velocyclegram#profile", as: 'profile'

  get "/followers/:id", to: "follow#followers", as: 'followers'
  get "/followings/:id", to: "follow#followings", as: 'followings'
  post "/follow", to: "follow#create"
  delete "/unfollow", to: "follow#delete"
end
