require 'active_resource'

class User < ActiveResource::Base
  extend ActiveModel::Naming
  self.site = Rails.configuration.account_ip
  self.prefix = "/api/"
  attr_writer :committees

  def posts
    @posts ||= Post.where(user_id: id)
  end

  def id
    uid
  end
  def self.find(id)
    return nil unless id.present?
    puts(id)
    Rails.cache.fetch("/api/users/#{id}.json") do
      user = super id
      user.groups.each do |group|
        user.groups = OpenStruct.new(group.attributes).to_h
      end
      user
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

  def committees_include_any?(committee)
    memberlist = committees.map(&:slug)
    !(committee & memberlist).empty?
  end

  def self.headers
    { 'Authorization' => "pre-shared #{Rails.application.secrets.client_credentials}"}
  end

end
