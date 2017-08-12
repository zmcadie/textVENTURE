Rails.application.routes.draw do
  get '/' => 'games#index'
  get '/games/:game_id' => 'games#show'
  get 'games/:game_id/states/:state_id' => 'states#show'
  post '/' => 'states#update'
end
