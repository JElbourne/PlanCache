Rails.application.routes.draw do
  mount_griddler
  resources :users
  root to: 'welcome#index'
  #post '/email_processor' => 'griddler/emails#create'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

end
