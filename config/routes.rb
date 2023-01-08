Rails.application.routes.draw do
  root 'home#index'
  resources :workshops, only: %i[index show]
  resources :bookings, only: %i[create]
end
