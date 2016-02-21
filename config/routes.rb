require 'api_constraints'

Rails.application.routes.draw do
  namespace :api, constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true)  do
      #api_sessions POST   /sessions(.:format)       api/v1/sessions#create
      #{:subdomain=>"api"}
      post '/sessions(.:format)', to: 'sessions#create', as: 'sign_in'
      delete '/sessions/:id(.:format)', to: 'sessions#destroy', as: 'sign_out'
      #resources :sessions, :only => [:create, :destroy]
      resources :users, :only => [:show, :create, :update, :destroy]
      resources :expenses, :only => [:show, :create, :update, :destroy]
      resources :categories, :only => [:index, :show, :create, :update, :destroy]

    end
  end
end
