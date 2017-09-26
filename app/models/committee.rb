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
    fetch_committee.positions.map { |i| i.split(';').reverse }.to_h
  end

  private
    def fetch_committee
      @committee ||= CommitteeLookup.find slug
    end

    class CommitteeLookup < ActiveResource::Base
      extend ActiveModel::Naming
      self.site = Rails.configuration.account_ip
      self.element_name = :group

      def self.headers
        { "authorization" => "Bearer #{AccessToken}" }
      end
    end
end
