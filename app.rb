require 'sinatra'
require 'sinatra/json'
require 'google/apis/youtube_v3'

require './env' if File.exists?('env.rb')

YOUTUBE_API_SERVICE_NAME = 'youtube'
YOUTUBE_API_VERSION = 'v3'

# See https://developers.google.com/youtube/v3/docs/search/list#examples
def get_service
  client = Google::Apis::YoutubeV3::YouTubeService.new
  client.key = ENV['GOOGLE_API_KEY']
  return client
end


get '/' do
  # Find the query string from the Slack command
  q = params['text']

  # Find the right video in Youtube
  client = get_service
  search_response = client.list_searches(
    'snippet',
    q: "Faemino y Cansado #{q}",
    type: 'video',
    safe_search: 'none',
    max_results: 10
  )

  # Pick a result at random
  selected_position = rand(search_response.items.size)
  selected_item = search_response.items[selected_position]

  # Return the video best matching the query string
  json({
    response_type: "in_channel",
    text: "#{selected_item.snippet.title} https://www.youtube.com/watch?v=#{selected_item.id.video_id}"
  })
end