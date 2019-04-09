Rails.application.routes.draw do
  get 'sessions/new'

  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers, :favorites
    end
  end
  resources :users do
  end
  resources :microposts, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  get '/hashtag/:name', to: "microposts#hashtag"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
