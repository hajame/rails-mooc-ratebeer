Rails.application.routes.draw do
  resources :styles
  resources :memberships
  resources :beer_clubs
  resources :users do
    post 'toggle_closed', on: :member
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resource :session, only: [:new, :create, :destroy]
  resources :beers
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  resources :ratings, only: [:index, :new, :create, :destroy]
  resources :places, only: [:index, :show]

  get 'kaikki_bisset', to: 'beers#index'
  get 'beerlist', to: 'beers#list'
  get 'brewerylist', to: 'breweries#list'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  post 'places', to: 'places#search'

  # Defines the root path route ("/")
  root "breweries#index"
end
