Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :recipes, only: %i[show new create edit update destroy]
  resources :cuisines, only: %i[show new create]
  resources :recipe_types, only: %i[show new create]
end
