# encoding: utf-8

class DocumentUploader < CarrierWave::Uploader::Base

  storage :file

  # Override the directory where uploaded files will be stored.
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.slug}"
  end

  def extension_white_list
   %w(pdf txt md)
  end

end
