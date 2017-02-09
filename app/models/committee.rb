class Committee < ActiveRecord::Base
  translates :title, :description
  globalize_accessors

  validates :slug, :name, *globalize_attribute_names, :url, :email, presence: true
  validates :slug, :name, uniqueness: true

  def to_param
    slug
  end
  def positions
    Rails.cache.fetch("positions/#{self.slug}2", expires_in: 30.minutes) do
      group = open(Rails.configuration.account_ip+"/groups/#{slug}.json",
      'Authorization' => "Bearer #{Rails.application.secrets.client_credentials}")
      JSON.parse(group.read)["positions"].map { |i| i.split(';').reverse }.to_h
    end
  end
end
