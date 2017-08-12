Rails.application.routes.draw do
  get '/' => 'games#index'
  get '/:id' => 'states#show'
  post '/' => 'states#update'
  get '/games/:id' => 'games#show'
end
