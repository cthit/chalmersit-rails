require 'active_resource'

class User < ActiveResource::Base
  extend ActiveModel::Naming
  self.site = Rails.configuration.account_ip

  def posts
    @posts ||= Post.find_by(user_id: id)
  end

  def id
    uid
  end

  def self.find(id)
    Rails.cache.fetch("users/#{id}.json") do
      super id
    end
  end

  def committees
    @committees ||= Committee.all.select do |c|
      groups.include?(c.slug)
    end
  end

  def in_committee?
    committees.any?
  end

  def self.headers
    { 'authorization' => "Bearer #{Rails.application.secrets.client_credentials}"}
  end

end
