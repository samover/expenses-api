require 'api_constraints'

Rails.application.routes.draw do
  get :sign_in, controller: 'application'
  get :sign_out, controller: 'application'
  namespace :api, constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true)  do
      resources :users, :only => [:show, :create, :update, :destroy]
      resources :expenses, :only => [:show, :create, :update, :destroy]
      resources :categories, :only => [:index, :show, :create, :update, :destroy]
    end
  end
end
