class Sponsor < ActiveRecord::Base
  mount_uploader :image, ArticleImageUploader
end
