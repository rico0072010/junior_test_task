Rails.application.routes.draw do
  root 'adverts#index'
  resources :adverts
  devise_for :users
  resources :users, only: [:show]
end
