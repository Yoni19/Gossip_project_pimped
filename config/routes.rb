Rails.application.routes.draw do

  root 'static_pages#index'

  resources :static_pages
  resources :gossips do
    resources :comments
  end
  resources :users
  resources :cities
  resources :sessions, only: [:new, :create, :destroy]
  resources :likes, only: [:show, :new, :create, :destroy]

  get '/team', to: 'static_pages#team'
  get '/contact', to: 'static_pages#contact'
  get '/welcome/', to: 'static_pages#welcome'
  get '/welcome/:anything', to: 'static_pages#welcome'

end
