class Upload < ActiveRecord::Base
  mount_uploader :source, ArticleImageUploader
end
