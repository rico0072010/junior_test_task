Rails.application.routes.draw do
  root 'adverts#index'
  resources :adverts do
    patch 'change_status', to: 'adverts#change_status'
  end
  devise_for :users
  resources :users, only: [:show]
  resources :tags, except: %i[index edit update]
end
