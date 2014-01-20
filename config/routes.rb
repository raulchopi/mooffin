Mooffin::Application.routes.draw do
  root :to => 'home#index'

  get '/signup' 	=> 'users#new', 		:as => 'signup'
  get '/recetas' 	=> 'recipes#show',		:as => 'recipes'

  get 'login'   	=> 'sessions#new',   	:as => 'login'
  get 'logout'  	=> 'sessions#destroy',  :as => 'logout'

  resources :users
  resources :sessions

  resources :ingredients
  
  #OAuth
  #get '/auth/:provider/callback', :to => 'sessions#create'
end
