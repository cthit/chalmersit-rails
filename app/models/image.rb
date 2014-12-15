class Image < ActiveRecord::Base
  mount_uploader :source, ArticleImageUploader
end
