Rails.application.routes.draw do
  jsonapi_resources :breweries
  jsonapi_resources :beers
  jsonapi_resources :reviews
  jsonapi_resources :states
end
