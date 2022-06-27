Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create]
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
