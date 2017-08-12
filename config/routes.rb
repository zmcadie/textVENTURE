Rails.application.routes.draw do
  get '/' => 'games#index'
  get '/games/:id' => 'games#show'
  get 'games/:id/states/:id' => 'states#show'
  post '/' => 'states#update'
end
