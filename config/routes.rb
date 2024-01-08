Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root "countries#index"

  resources :countries do
    get :state, on: :member
  end
  resources :states 
  resources :cities
  get '/states/:country_id/fetch_states', to: 'states#fetch_states'
  get '/countries/:country_id/status', to: 'countries#status'
end
