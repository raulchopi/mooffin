Mooffin::Application.routes.draw do
  root :to => 'home#index'

  get '/signup' 	=> 'users#new', 		:as => 'signup'

  get 'login'   	=> 'sessions#new',   	:as => 'login'
  get 'logout'  	=> 'sessions#destroy',  :as => 'logout'

  get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
  get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session

  resources :users do
    resources :likes
  end

  resources :sessions

  resources :ingredients
  resources :difficulties
  resources :units
  resources :importances
  resources :recipes do
    resources :opinions
    resources :likes
  end

  get '/proposals' => 'recipes#proposals'

  resources :links
  resources :likes
  resources :opinions


  #OAuth
  get '/auth/:provider/callback', :to => 'sessions#create'
end
