Rails.application.routes.draw do
  resources :counties
  resources :item_counties
  resources :item_locations
  resources :items
  resources :locations
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
