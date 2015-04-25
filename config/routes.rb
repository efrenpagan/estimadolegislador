Rails.application.routes.draw do

  namespace :api do
    resources :emails, :legislators
  end

  root 'angular#root'
  get "*path" => "angular#root"

end
