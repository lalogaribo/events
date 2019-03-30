Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resource :sessions, only: [:create, :destroy]
      resources :categories do
        resources :events, only: [:index]
      end
      resources :events
      resources :tickets
      resources :carts
      resources :users, only: [:create]
    end
  end
end
