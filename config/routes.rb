Mooffin::Application.routes.draw do
  root :to => 'home#index'

  get '/',			:to => 'home#index'
  get '/signup', 	:to => 'users#new'

  get 'login'   => 'sessions#new',        :as => 'login'
  get 'logout'  => 'sessions#destroy',    :as => 'logout'
  
  #OAuth
  get '/auth/:provider/callback', :to => 'sessions#create'
end
