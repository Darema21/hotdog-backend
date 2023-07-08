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
      resources :owners, only: [:show, :update, :deactivate] do
        member do
          get :matches
        end
      end

      resources :matches, only: [:create, :show, :destroy]
    end
  end

end
