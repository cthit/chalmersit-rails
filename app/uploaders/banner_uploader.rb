# encoding: utf-8

class BannerUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process crop: :image

  storage :file

  def store_dir
    "uploads/banners/#{model.group_id}"
  end
end
