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
      get 'current_user', to: 'users#current_user'
      post 'change_password', to: 'users#change_password'
      put 'update_current', to: 'users#update_current'

      resources :trips
      get 'filter_data', to: 'trips#filter_data'

      resources :addresses
      resources :places
      resources :trip_place_infos
      resources :ratings, only: :create

      resources :journeys, except: :destroy
      get 'current_journey', to: 'journeys#current_journey'
      put 'update_place_status', to: 'journeys#update_place_status'
    end
  end
end
