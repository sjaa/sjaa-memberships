Rails.application.routes.draw do

  get '/reports/ephemeris', to: 'reports#ephemeris', as: :ephemeris_report

  get '/people/:id/new_membership', to: 'people#new_membership', as: :membership_renewal
  post '/memberships/order', to: 'memberships#create_order', as: :membership_order
  post '/memberships/capture_order', to: 'memberships#capture_order', as: :membership_capture_order

  post '/people/search', to: 'people#search', as: :people_search
  get '/people/search', to: 'people#search'
  post '/donations/search', to: 'donations#search', as: :donations_search
  get '/donations/search', to: 'donations#search'
  post '/equipment/search', to: 'equipment#search', as: :equipment_search
  get '/equipment/search', to: 'equipment#search'
  post '/roles/add_person', to: 'roles#add_person', as: :roles_add_person

  post '/password_resets/:id', to: 'password_resets#update', as: :password_reset_form
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :donation_phases
  resources :donation_items
  resources :people do
    resources :donations
    resources :interests
    resources :memberships
    resources :equipment
    resources :contacts
  end

  resources :roles
  resources :permissions
  resources :admins
  resources :referrals
  resources :instruments
  resources :equipment
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
  get '/google/members', to: 'google#members', as: :google_members
  get '/google/auth', to: 'sessions#request_google_authorization', as: :google_auth
  get '/google/callback', to: 'sessions#google_oauth2_callback', as: :google_callback
  get '/login', to: 'sessions#login', as: :login
  get '/logout', to: 'sessions#destroy', as: :logout
  get '/member_login', to: 'sessions#public_login', as: :public_login
  post '/member_lookup', to: 'sessions#member_lookup', as: :member_lookup
  post '/new_member', to: 'sessions#new_member', as: :new_member
  get '/unauthorized', to: 'static_pages#unauthorized', as: :unauthorized

end
