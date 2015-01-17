require 'rest-client'
require 'json'

namespace :cthit do
  desc "Get an access token from account.chalmers.it"
  task :generate_token do
    response = RestClient.post "#{ENV['ACCOUNT_IP']}/oauth/token", {
      grant_type: 'client_credentials',
      client_id: ENV["OAUTH_ID"],
      client_secret: ENV["OAUTH_SECRET"]
    }
    token = JSON.parse(response)["access_token"]

    puts "Access token: #{token}"
  end
end
