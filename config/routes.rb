Rails.application.routes.draw do

  get 'secret/index'

  get 'main/index'
  get 'search' => 'main#index', as: :search
  get 'newCall' => 'main#newCall', as: :newCall
  get 'validations' => 'validations'
  get 'settings' => 'settings#index', as: :settings
  get "downloadPRC" => 'settings#downloadPRC', as: :downloadPRC
  get "changePassword" => 'settings#change', as: :passwordForm

  post "changePassword" => 'settings#change', as: :changePassword

  post 'clear_form' => 'main#clear_form', as: :clear_form
  post 'newCall' => 'main#newCall'
  post 'submit_form' => 'main#submit_form'

  root 'main#index'
  resources :items
  resources :counties
  resources :item_counties
  resources :item_locations
  resources :locations
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
