require 'twitter'
$twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = '' # YOUR_CONSUMER_KEY
  config.consumer_secret = '' # YOUR_CONSUMER_SECRET
  config.access_token = '' # YOUR_OAUTH_TOKEN
  config.access_token_secret = '' # YOUR_OAUTH_TOKEN_SECRET
end