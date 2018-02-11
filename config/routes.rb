Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :user_profiles, only: [:create, :update, :show]
  resources :donations, :donation_requests, :donation_items


  get '/home/nearby_organizations', to: 'home#nearby_organizations'


end
