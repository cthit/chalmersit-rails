require 'twitter'
$twitter = Twitter::REST::Client.new do |config|
  twitter_settings = Rails.application.secrets.twitter
  config.consumer_key = twitter_settings['consumer_key']
  config.consumer_secret = twitter_settings['consumer_secret']
  config.access_token = twitter_settings['access_token']
  config.access_token_secret = twitter_settings['access_token_secret']
end