require "sinatra"

set :port, 5000

get '/print_tweet' do
  erb :tweet
end
