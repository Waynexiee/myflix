Myflix::Application.routes.draw do

  root to: 'pages#front'
  resources :videos, only: [:show, :index] do
    collection do
      get :search, to: 'videos#search'
    end
  end
  get '/register', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get 'ui(/:action)', controller: 'ui'

  resources :users
end
