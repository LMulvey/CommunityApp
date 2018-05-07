Rails.application.routes.draw do
  namespace :api do
    resources :bands
    resources :users
    resources :band_memberships
  end

  post '/login', to: 'sessions#create'
end
