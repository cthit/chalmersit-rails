class Sponsor < ActiveRecord::Base
  mount_uploader :image, SponsorImageUploader
  translates :title
  globalize_accessors

  def self.sponsor_admins
    %w(armit)
  end
end
