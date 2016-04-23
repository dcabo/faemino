require 'sinatra'
require 'sinatra/json'

get '/' do
  json {
    response_type: "in_channel",
    text: "El budista https://www.youtube.com/watch?v=K_wJsX8FQVg"
  }
end