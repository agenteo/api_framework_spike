Rails.application.routes.draw do
  get '/api/v1/articles/:id', to: 'api/v1/articles#show'
  post '/api/v1/articles', to: 'api/v1/articles#create'
end
