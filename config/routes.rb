Myflix::Application.routes.draw do

  get 'friendships/create'

  get 'friendships/destroy'

  root to: 'pages#front'

  resources :videos, only: [:show, :index] do
    collection do
      get :search, to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end

  get '/register', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get 'ui(/:action)', controller: 'ui'
  get '/my_queue', to: 'queue_items#index'
  post '/my_queue', to: 'queue_items#create'
  delete '/my_queue', to: 'queue_items#destroy'
  post '/update_queue', to: 'queue_items#update_queue'
  get '/confirm_password_reset', to: 'pages#confirm_password_reset'
  get '/token_expired', to: 'pages#token_expired'
  resources :password_resets,  only: [:new, :create, :edit, :update]
  resources :users
  resources :people, controller: :friendships
  resources :invitations, only: [:new, :create]
end
