Rails.application.routes.draw do

  get 'main/index'
  get 'validations' => 'main#validations', as: :validations
  get 'search' => 'main#index', as: :search
  get 'newCall' => 'main#newCall', as: :newCall

  post 'newCall' => 'main#newCall'

  root 'main#index'
  resources :items
  resources :counties
  resources :item_counties
  resources :item_locations
  resources :locations
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
