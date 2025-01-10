Rails.application.routes.draw do
  resources :donation_phases
  resources :donation_items
  resources :people do
    resources :donations
    resources :interests
    resources :memberships
    resources :equipment
    resources :contacts
  end

  resources :permissions
  resources :admins
  resources :referrals
  resources :instruments
  resources :equipment
  resources :groups
  resources :states
  resources :contacts
  resources :statuses
  resources :memberships
  resources :astrobins
  resources :cities
  resources :donations
  resources :interests

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "people#index"

  #resources :api_keys
  post '/api-keys', to: 'api_keys#create'
  delete '/api-keys', to: 'api_keys#destroy'
  get '/api-keys', to: 'api_keys#index'

  resource :sessions
  get '/login', to: 'sessions#login', as: :login
  get '/logout', to: 'sessions#destroy', as: :logout
  get '/unauthorized', to: 'static_pages#unauthorized', as: :unauthorized
  post '/people/search', to: 'people#search', as: :people_search
end
