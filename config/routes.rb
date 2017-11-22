Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :recipes
  resources :cuisines, only: %i[show new create]
  resources :recipe_types, only: %i[show new create]
end
