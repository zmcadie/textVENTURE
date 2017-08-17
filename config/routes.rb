Rails.application.routes.draw do
  get '/' => 'games#index'
  # form for adding game to db
  get '/games/new' => 'games#new'
  post '/games/new' => 'games#create'
  post 'games/new' => 'games#save_game'
  # form for adding actions to states via 'connections'
  get '/games/new/:new_id/states/connections' => 'games#connections'
  get '/games/new/:new_id/states/:state_id/connections' => 'games#connections_show'
  post '/games/new/:new_id/states/:state_id/connections' => 'games#create_connections'
  # form for adding states to game
  get '/games/new/:new_id/states' => 'games#states'
  post '/games/new/:new_id/states' => 'games#states_create'
  # view for individual states already created (sidebar links)
  get '/games/new/:new_id/states/:state_id' => 'games#states_show'

  get '/games/:game_id' => 'games#show'
  post '/' => 'states#update'
  post '/games' => 'games#select'
end
