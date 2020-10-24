Rails.application.routes.draw do
  root 'adverts#index'
  resources :adverts do
    patch 'change_status', to: 'adverts#change_status'
    resources :comments, only: %i[index destroy create]
  end
  devise_for :users
  resources :users, only: [:show]
  resources :tags, except: [:destroy]
  get 'search_adverts', to: 'adverts#search'
end
