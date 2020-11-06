Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/backoffice', as: 'rails_admin'

  resources :leads
  resources :quotes , only: [:user_quotes, :new, :create]
  root to: 'static_pages#index'
  get 'static_pages/residential'
  get 'static_pages/corporate'
  get 'static_pages/map'

  #devise_for :users, :controllers => { registrations: 'registrations'}, :path_prefix => '', :path => 'u', path_names: { sign_in: 'sign_in', sign_out: 'sign_out', password: 's', confirmation: 'v' }
  devise_for :users, :controllers => { :registrations => "users/registrations", :path_prefix => '', :path => 'u', path_names: { sign_in: 'sign_in', sign_out: 'sign_out', password: 's', confirmation: 'v' }, :sessions => "users/sessions", :passwords => "users/passwords" }


  match '/watson' => 'watson#speak', via: :get
  get 'my_quotes' => 'quotes#user_quotes', as: :my_quotes
  get 'map' => 'static_pages#map', as: :map
  get 'my_leads' => 'leads#user_leads', as: :my_leads
end
