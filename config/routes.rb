Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'login', to: 'sessions#login', as: :login
      resources :dogs do
        member do
          post :upload
        end
      end

      resources :owners, only: [:show, :update] do
        member do
          get :matches, only: [:index, :destroy]
          post :matches, to: 'matches#create'
        end
      end

      resources :matches, only: [:show]

      resources :matches, only: [] do
        resources :comments, only: [:show, :create, :index]
      end

      resources :breeds, only: [:index, :show]

      resources :events do
        member do
          post :booking, to: 'bookings#create'
          post :upload_image
        end
        collection do
          get :category, to: 'events#category'
        end
      end
    end
  end

end
