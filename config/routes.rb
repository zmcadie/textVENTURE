Rails.application.routes.draw do
  get '/' => 'states#index'
  get '/:id' => 'states#show'
  post '/' => 'states#update'
end
