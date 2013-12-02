Mooffin::Application.routes.draw do
  root :to => 'home#index'

  get '/',		:to => 'home#index'
  get '/signup', 	:to => 'users#new'
  
  #OAuth
  get '/auth/:provider/callback', :to => 'sessions#create'
end
