require 'sinatra'
set :environment, :production
set :logging, true

require 'mongoid'
Mongoid.load!("config/mongoid.yml")

require './app/article'
require "json"

get '/api/v1/articles/:id' do
  content_type :json
  { title: 'Test title', body: 'Test body' }.to_json
end


# POST /api/v1/articles
post '/api/v1/articles' do
  parsed_post_data = JSON.parse( request.body.read )
  article = Article.new(parsed_post_data['article'])
  if article.save
    article.to_json
  else
    article_errors = article.errors.to_json
    status 400
    { message: 'There was a problem.',
      article: { errors: article_errors } }.to_json
  end
end
