Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :beers
  resources :breweries
  get 'kaikki_bisset', to: 'beers#index'

  resources :ratings, only: [:index, :new, :create, :destroy]

  # Defines the root path route ("/")
  root "breweries#index"
end
