Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api, defaults: { format: :json } do
  #   namespace :v1 do
  #     post 'login', to: 'sessions#login', as: :login
  #   end
  end
end
