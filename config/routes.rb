Rails.application.routes.draw do

  resources :users
  root to: 'welcome#index'
  get "/email_processor", to: proc { [200, {}, ["OK"]] }, as: "mandrill_head_test_request"
  post '/email_processor' => 'griddler/emails#create'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

end
