Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'login', to: 'sessions#login', as: :login
      resources :dogs do
        member do
          post :upload_image
        end
      end
      resources :owners, only: [:show, :update] do
        member do
          get :matches, only: [:show, :destroy]
          post :matches, to: 'matches#create'
          # resources :comments, only: [:show, :create], module: :matches
        end
        resources :matches, only: [] do
          resources :comments, only: [:show, :create, :index]
        end
      end
      resources :breeds, only: [:index, :show]

      # get 'breeds/:id', to: 'breeds#show_by_id', as: :breed_by_id
      # get 'breeds/name/:name', to: 'breeds#show_by_name', as: :breed_by_name

    end
  end

end
