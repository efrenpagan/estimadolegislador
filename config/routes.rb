Rails.application.routes.draw do

  namespace :api do
    resources :emails
    resources :legislators do
    	collection do
    		get 'search'
    	end
    end
  end

  root 'angular#root'
  get "*path" => "angular#root"

end
