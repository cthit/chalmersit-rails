require 'active_resource'

class User < ActiveResource::Base
  extend ActiveModel::Naming
  self.site = Rails.configuration.account_ip

  def posts
    @posts ||= Post.find_by(user_id: uid)
  end

  def self.find(id)
    Rails.cache.fetch("users/#{id}.json") do
      super id
    end
  end

  def self.headers
    { 'authorization' => "Bearer #{Rails.application.secrets.client_credentials}"}
  end

end
