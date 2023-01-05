// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery3
//= require popper
//= require bootstrap-sprockets
import "@hotwired/turbo-rails"
import "controllers"
import { beers } from "custom/beer_table"
import { breweries } from "custom/brewery_table"

beers()
breweries()
