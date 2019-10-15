class Committee < ActiveRecord::Base
  has_many :posts, primary_key: :slug, foreign_key: :group_id
  translates :title, :description
  globalize_accessors

  validates :slug, :name, *globalize_attribute_names, :url, :email, presence: true
  validates :slug, :name, uniqueness: true

  def to_param
    slug
  end
  def positions
    Rails.cache.fetch("groupMembers/#{self.slug}", expires_in: 30.minutes) do
      group = open(Rails.configuration.account_ip+"/api/superGroups/#{slug}/active.json",
      'Authorization' => "pre-shared #{Rails.application.secrets.client_credentials}")
      j = JSON.parse(group.read).map { |g| g["groupMembers"].map {|i| [i["userCid"],i["unofficialPostName"]]}.to_h}
      end
    end
  end
