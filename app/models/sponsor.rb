class Sponsor < ActiveRecord::Base
  before_validation :remove_empty_image_links
  validate :image_link_is_valid_url_or_nil?
  mount_uploader :image, SponsorImageUploader
  translates :title
  globalize_accessors

  def self.sponsor_admins
    %w(armit)
  end

  private
  def remove_empty_image_links
    self.imagelink.strip!
    if self.imagelink.length == 0
      self.imagelink = nil
    end
  end

  def image_link_is_valid_url_or_nil?
    if self.imagelink == nil
      return true
    end
    
    uri = URI.parse(self.imagelink) and !uri.host.nil?
    if not uri.is_a?(URI::HTTP) && !uri.host.nil?
      errors.add(:imagelink, :link_not_valid_url)
      return false
    end
    return true
  rescue URI::InvalidURIError
    errors.add(:imagelink, :link_not_valid_url)
    return false
  end
  
end
