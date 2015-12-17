Rails.application.routes.draw do

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api do
    resources :messages
    resources :contacts do
    	collection do
    		get 'search'
    	end
    end
    resources :workers, only: [:show]
    resources :message_events, only: [:create]
  end

  root 'angular#root'
  get "*path" => "angular#root"

end
