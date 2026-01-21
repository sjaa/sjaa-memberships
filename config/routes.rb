Rails.application.routes.draw do
  mount DocumentArchive::Engine => "/document_archive"

  resources :app_configs, only: [:index, :edit, :update] do
    collection do
      post :seed_from_env
    end
  end
  resources :tags
  mount MissionControl::Jobs::Engine, at: "/jobs"
  
  get '/mentorship', to: 'mentorship#index', as: :mentorship
  post '/mentorship/search', to: 'mentorship#search', as: :mentorship_search
  get '/mentorship/search', to: 'mentorship#search'
  post '/mentorship/contact/:id', to: 'mentorship#contact', as: :mentor_contact

  get '/reports/memberships', to: 'reports#memberships', as: :memberships_report
  post '/reports/create_google_group', to: 'reports#create_google_group', as: :create_google_group_report
  get '/reports/renewal_reminders', to: 'reports#renewal_reminders', as: :renewal_reminders
  get '/reports/ephemeris', to: 'reports#ephemeris', as: :ephemeris_report
  get '/signup', to: 'sessions#signup', as: :signup
  post '/signup_request', to: 'sessions#signup_request', as: :signup_request
  get '/confirm_email/:token', to: 'sessions#signup_response', as: :signup_response
  
  get '/people/remind_all', to: 'people#remind_all', as: :remind_all
  get '/people/:id/new_membership', to: 'people#new_membership', as: :membership_renewal
  post '/people/:id/approve_mentorship', to: 'people#approve_mentorship', as: :approve_mentorship
  post '/people/:id/deny_mentorship', to: 'people#deny_mentorship', as: :deny_mentorship
  post '/people/:id/admin_renew', to: 'people#admin_renew', as: :admin_renew_person
  get '/people/verify', to: 'people#verify_form', as: :verify_membership_form
  post '/people/verify', to: 'people#verify', as: :verify_membership
  post '/memberships/order', to: 'memberships#create_order', as: :membership_order
  post '/memberships/capture_order', to: 'memberships#capture_order', as: :membership_capture_order
  
  get '/people/remind/:id', to: 'people#remind', as: :reminder_email
  get '/people/welcome/:id', to: 'people#welcome', as: :welcome_email
  post '/people/search', to: 'people#search', as: :people_search
  get '/people/search', to: 'people#search'
  post '/people/bulk_add_to_groups', to: 'people#bulk_add_to_groups', as: :bulk_add_to_groups
  post '/donations/search', to: 'donations#search', as: :donations_search
  get '/donations/search', to: 'donations#search'
  get '/donations/letter/:id', to: 'donations#send_letter', as: :donations_letter
  post '/donations/:id/send_letter', to: 'donations#send_letter_with_options', as: :send_donation_letter
  get '/donations/:id/preview_letter', to: 'donations#preview_letter', as: :preview_donation_letter
  post '/equipment/search', to: 'equipment#search', as: :equipment_search
  get '/equipment/search', to: 'equipment#search'
  post '/groups/add_person', to: 'groups#add_person', as: :groups_add_person
  post '/groups/:id/import_csv', to: 'groups#import_csv', as: :import_csv_group
  
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
  
  resources :groups
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
  resources :skills

  # Notifications
  resources :notifications, only: [:index, :destroy] do
    collection do
      get :unread
      get :unread_count
      patch :mark_all_as_read
      delete :clear_all
    end
    member do
      patch :mark_as_read
    end
  end

  # Opportunities
  resources :opportunities do
    member do
      post :contact
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  # Defines the root path route ("/")
  # Redirect to appropriate page based on user type
  root "home#index"
  
  # API Keys
  resources :api_keys

  # APIs
  scope :api, defaults: {format: :json} do
    # Manage keys
    post '/keys', to: 'api_keys#create'
    delete '/keys', to: 'api_keys#destroy'
    get '/keys', to: 'api_keys#index'

    resources :people
  end
  
  resource :sessions
  get '/setup', to: 'setup#index', as: :setup
  get '/google/groups', to: 'google#groups', as: :google_groups
  get '/google/group_sync', to: 'google#group_sync', as: :google_group_sync
  get '/google/members', to: 'google#members', as: :google_members
  get '/google/auth', to: 'sessions#request_google_authorization', as: :google_auth
  get '/google/callback', to: 'sessions#google_oauth2_callback', as: :google_callback
  get '/login', to: 'sessions#login', as: :login
  get '/logout', to: 'sessions#destroy', as: :logout
  post '/member_lookup', to: 'sessions#member_lookup', as: :member_lookup
  post '/new_member', to: 'sessions#new_member', as: :new_member
  get '/unauthorized', to: 'static_pages#unauthorized', as: :unauthorized

  # Widgets
  get '/widgets/meetup', to: 'widget#meetup', as: :widget_meetup

end
