require 'active_resource'

class User < ActiveResource::Base
  extend ActiveModel::Naming
  self.site = Rails.configuration.account_ip
  attr_writer :committees

  def posts
    @posts ||= Post.where(user_id: id)
  end

  def id
    uid
  end

  def self.find(id)
    return nil unless id.present?
    Rails.cache.fetch("users/#{id}.json") do
      user = super id
      user.positions = OpenStruct.new(user.positions.attributes).to_h
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
    { authorization: "Bearer #{AccessToken}" }
  end

end
