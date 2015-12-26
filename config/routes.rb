Mooffin::Application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root :to => 'home#index'

  get '/signup' 	=> 'users#new', 		:as => 'signup'

  get 'login'   	=> 'sessions#new',   	:as => 'login'
  get 'logout'  	=> 'sessions#destroy',  :as => 'logout'

  get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
  get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session

  resources :users, path: 'usuarios' do
    resources :likes, path: 'favoritas'
  end

  path_names_fem = { new: 'nueva', edit: 'editar' }
  path_names_masc = { new: 'nuevo', edit: 'editar' }

  resources :sessions

  resources :ingredients
  resources :difficulties
  resources :courses
  resources :units
  resources :importances
  resources :recipes, path: 'receta', path_names: path_names_fem do
    resources :opinions
    resources :likes, path: 'favoritas'
    resources :reports
  end

  get '/proposals' => 'recipes#proposals'
  get '/recipeopinions' => 'opinions#recipeopinions'
  get '/userrecipes' => 'users#userrecipes'
  get '/userRecipeLike' => 'likes#getUserRecipeLike'
  get '/lastRecipes' => 'recipes#getLastRecipes'
  get '/categoryrecipes' => 'categories#getCategoryRecipes'

  resources :links
  resources :likes, path: 'favoritas'
  resources :opinions
  resources :partners
  resources :reasons
  resources :categories, path: 'recetas'

  #OAuth
  get '/auth/:provider/callback', :to => 'sessions#create'

  # API
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :recipes, only: [:index, :show]
      resources :ingredients, only: [:index]
      resources :proposals, only: [:index]
      resources :likes, only: [:show]
    end
  end


end
