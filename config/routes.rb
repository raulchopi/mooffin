Mooffin::Application.routes.draw do
  ##OAuth
  get '/auth/:provider/callback', :to => 'sessions#create'
end
