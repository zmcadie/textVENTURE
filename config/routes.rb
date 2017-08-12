Rails.application.routes.draw do
  get '/' => 'states#index'
  get '/:id' => 'states#show'
  post '/' => 'states#update'
  get '/games/:id' => 'games#show'
end
