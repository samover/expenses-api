require 'api_constraints'

Rails.application.routes.draw do
  namespace :api, constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true)  do
      resources :expenses, :only => [:index, :show, :create, :update]
    end
  end
end
