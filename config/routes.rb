Rails.application.routes.draw do
  resources :geolocations, only: %i[create show destroy]
end
