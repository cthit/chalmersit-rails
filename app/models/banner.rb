class Banner < ActiveRecord::Base
  mount_uploader :image, SponsorImageUploader
  belongs_to :group, class_name: 'Committee'
  def group
    @group ||= Committee.find_by(slug: group_id)
  end
end
