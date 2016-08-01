class Sponsor < ActiveRecord::Base
  mount_uploader :image, SponsorImageUploader
end
