class Sponsor < ActiveRecord::Base
  mount_uploader :image, SponsorImageUploader
  translates :title
  globalize_accessors
end
