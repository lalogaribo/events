Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:create, :destroy]
      resources :categories do
	      resources :events, only: [:index]
      end
      resources :events
      resources :tickets
      resources :carts
    end
  end
end
