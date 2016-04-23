require 'sinatra'
require 'sinatra/json'
require 'google/api_client'

require './env' if File.exists?('env.rb')

YOUTUBE_API_SERVICE_NAME = 'youtube'
YOUTUBE_API_VERSION = 'v3'

# See https://developers.google.com/youtube/v3/docs/search/list#examples
def get_service
  client = Google::APIClient.new(
    :key => ENV['GOOGLE_API_KEY'],
    :authorization => nil,
    :application_name => $PROGRAM_NAME,
    :application_version => '1.0.0'
  )
  youtube = client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)

  return client, youtube
end


get '/' do
  # Find the query string from the Slack command

  # Find the right video in Youtube
  client, youtube = get_service
  search_response = client.execute!(
    :api_method => youtube.search.list,
    :parameters => {
      :part => 'snippet',
      :q => 'Faemino Manuel Campo Vidal',
      :type => 'video',
      :maxResults => 1
    }
  )

  # Return the video best matching the query string
  json({
    response_type: "in_channel",
    text: "For #{params['text']} #{search_response.data.items[0].snippet.title} " +
          "https://www.youtube.com/watch?v=#{search_response.data.items[0].id.videoId}"
  })
end