# encoding: utf-8

class DocumentUploader < CarrierWave::Uploader::Base
  storage :file

  # Override the directory where uploaded files will be stored.
  def store_dir
    "uploads/documents/#{Date.today.strftime '%Y/%m'}"
  end

  def extension_white_list
   %w(pdf txt md)
  end

  def filename
    md5(original_filename) if original_filename.present?
  end

  private

    def md5(filename)
      Digest::MD5.hexdigest(filename + Time.now.to_s)[0..10] + File.extname(filename)
    end

end
