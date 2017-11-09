Rails.application.routes.draw do
  root to: 'home#index'
  resources :recipes, only: %i[show new create]
  resources :cuisines, only: %i[show]
end
