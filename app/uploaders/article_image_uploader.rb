# encoding: utf-8
require 'digest/md5'

class ArticleImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/media/#{Date.today.strftime '%Y/%m'}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end
  process resize_to_limit: [1500, 1500], :if => :image?

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(pdf md txt jpg jpeg gif png webp)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    File.basename(original_filename,File.extname(original_filename)) + '-' + md5(original_filename) if original_filename.present?
  end

  private

    def md5(filename)
      Digest::MD5.hexdigest(filename + Time.now.to_s)[0..10] + File.extname(filename)
    end

    def too_large?(image)
      return unless image?(image)
      width, height = ::MiniMagick::Image.open(file.file)[:dimensions]
      width > 500 || height > 500
    end

    def image?(new_file)
      new_file.content_type.start_with? 'image'
    end
end
