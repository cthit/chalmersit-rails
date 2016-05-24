class Upload < ActiveRecord::Base
  mount_uploader :source, ArticleImageUploader
  validates_presence_of :source
  validates_integrity_of :source

end
