Rails.application.routes.draw do

  devise_for :users
  namespace :api do
    resources :messages
    resources :contacts do
    	collection do
    		get 'search'
    	end
    end
    resources :workers, only: [:show]
  end

  root 'angular#root'
  get "*path" => "angular#root"

end
