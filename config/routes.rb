Rails.application.routes.draw do
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resource :session, only: [:new, :create, :destroy]
  resources :beers
  resources :breweries
  resources :ratings, only: [:index, :new, :create, :destroy]

  get 'kaikki_bisset', to: 'beers#index'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  # Defines the root path route ("/")
  root "breweries#index"
end
