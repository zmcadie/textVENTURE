Rails.application.routes.draw do
  get '/' => 'games#index'
  # form for adding game to db
  get '/games/new' => 'games#new'
  post '/games/new' => 'games#new'
  # form for adding states to game
  get '/games/:new_id/states' => 'games#states'
  post '/games/:new_id/states' => 'games#states'
  # view for individual states already created (sidebar links)
  get '/games/:new_id/states/:state_id' => 'games#states'
  # form for adding actions to states via 'connections'
  get '/games/:new_id/states/:state_id/connections' => 'games#connections'
  post '/games/:new_id/states/:state_id/connections/:connection_id' => 'games#connections'

  get '/games/:game_id' => 'games#show'
  get 'games/:game_id/states/:state_id' => 'states#show'
  post '/' => 'states#update'
  post '/games' => 'games#select'
end
