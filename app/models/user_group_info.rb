class UserGroupInfo < ActiveRecord::Base
  translates :body
  globalize_accessors

  belongs_to :group, class_name: 'Committee'

  validates *globalize_attribute_names, :user_id, :group_id, presence: true, allow_blank: false
  validates *globalize_attribute_names, presence: true, allow_blank: false

end
