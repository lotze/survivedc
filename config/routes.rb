SurviveDc::Application.routes.draw do
  get "friend_requests/create" => "friend_requests#create", :as => :friend_request
  get "friend_requests/approve/:code" => "friend_requests#approve", :as => :friend_approve

  get "notice/show" => "notice#show", :as => :notice

  get "tag/new", :as => :new_tag
  get "tag/create", :as => :create_tag

  get "c/:code" => "checkin#create", :as => :qr_checkin
  post "checkin/create" => "checkin#create", :as => :checkin
  get "checkin/new", :as => :manual_checkin

  get "users/main", :as => :homescreen
  get "users/status" => "users#current_status", :as => :current_status
  get "users/history" => "users#history", :as => :personal_history
  get "users/history/:code" => "users#public_history", :as => :public_history
  get "rules/index", :as => :rules
  get "feed/index", :as => :feed
  get "map/index", :as => :map

  get "status/runners", :as => :runners
  get "status/checkpoints", :as => :checkpoints
  get "status/chasers", :as => :chasers

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  get "users/new" => "users#new"
  post "users" => "users#create"
  resources :sessions
  resources :password_resets
  get "activate/:code" => "users#activate", :as => :activation
  
  get "loc" => 'location#record', :as => 'location'
  root :to => "landing#index"
end
