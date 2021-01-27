Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  
  resources :users, only: [:show, :new, :create, :edit, :update, :destroy] do
    member do
      get :followings
      get :likes
    end
  end
  
  resources :microposts, only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :musics, only: [:index] do
    collection do
      get :erize
      get :koinu
      get :moon
      get :genso
    end
  end
  
  resources :practices, only: [:create]
  get '/rank', to: 'rankings#rank'
end