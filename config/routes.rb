Mooffin::Application.routes.draw do
	get "home/index"
  
  #OAuth
  get '/auth/:provider/callback', :to => 'sessions#create'
end
