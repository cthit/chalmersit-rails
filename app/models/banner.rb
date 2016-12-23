class Banner < ActiveRecord::Base
  mount_uploader :image, BannerUploader
  crop_uploaded :image
  belongs_to :group, class_name: 'Committee'
  def group
    @group ||= Committee.find_by(slug: group_id)
  end
end
