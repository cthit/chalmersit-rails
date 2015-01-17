require 'active_resource'

class User < ActiveResource::Base
  self.site = ENV['ACCOUNT_IP']

  def self.headers
    { 'authorization' => "Bearer #{Rails.application.secrets.client_credentials}"}
  end
end
