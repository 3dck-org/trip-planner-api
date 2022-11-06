Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create]
      resources :trips do
        member do
          put 'add_to_favorite', to: 'trips#add_to_favorite'
          put 'remove_from_favorite', to: 'trips#remove_from_favorite'
        end
      end
      resources :addresses
      resources :places
      resources :trip_place_infos
      resources :journeys, except: :destroy
      get 'current_journey', to: 'journeys#current_journey'
      get 'current_user', to: 'users#current_user'
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
