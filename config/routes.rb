Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :recipes do
    post 'favorite', on: :member
  end
  get 'favorite_recipes', to: 'home#favorites', as: 'favorite_recipes'
  resources :cuisines, only: %i[show new create]
  resources :recipe_types, only: %i[show new create]
end
