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
    cid
  end

  def self.find(id)
    return nil unless id.present?
      user = super id
      user.groups = user.groups.map { | group |
        group.attributes.to_h
      }
      user
  end

  def committees
    group_names = groups.select { |group| group.name }.map { |group| group["superGroup"].name }
    @committies ||= Committee.all.select do |c|
      group_names.include?(c.slug)
    end
  end

  def is_admin?
    self.authorities.map { |authority| authority.authority }.include?("admin")
  end

  def in_committee?
    committees
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
