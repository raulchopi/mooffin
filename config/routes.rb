Mooffin::Application.routes.draw do
  root :to => 'home#index'

  get '/signup' 	=> 'users#new', 		:as => 'signup'
  get '/recetas' 	=> 'recipes#show',		:as => 'recipes'
  get '/recetas/nueva'  => 'recipes#new',    :as => 'new_recipe'
  get '/recetas/:id' => 'recipes#show', :as => 'recipe'

  get 'login'   	=> 'sessions#new',   	:as => 'login'
  get 'logout'  	=> 'sessions#destroy',  :as => 'logout'

  get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
  get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session

  resources :users
  resources :sessions

  resources :ingredients
  
  #OAuth
  get '/auth/:provider/callback', :to => 'sessions#create'
end
