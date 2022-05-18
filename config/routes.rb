Rails.application.routes.draw do
  resources :follows
  resources :followings
  devise_for :users
  root "application#index"
  get "/:id", to: "velocyclegram#user_profile"
end
