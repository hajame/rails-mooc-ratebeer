Rails.application.routes.draw do
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :beers
  resources :breweries
  resources :ratings, only: [:index, :new, :create, :destroy]

  get 'kaikki_bisset', to: 'beers#index'
  get 'signup', to: 'users#new'

  # Defines the root path route ("/")
  root "breweries#index"
end
