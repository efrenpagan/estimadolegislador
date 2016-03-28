Rails.application.routes.draw do

  devise_for :users
  ActiveAdmin.routes(self)

  namespace :api do
    resources :messages do
      collection do
    		get 'search'
    	end
    end
    resources :contacts do
    	collection do
    		get 'search'
    	end
    end
    resources :workers, only: [:show]
    resources :message_events, only: [:create]
  end

  resources :messages, only: [:index, :new, :show]

  get '/register',  to: 'angular#root', as: 'register'
  get '/login',     to: 'angular#root', as: 'login'

  root 'angular#root'
end
