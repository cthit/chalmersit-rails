class Print
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming


  def self.available_ppi
    %w(auto 600 1200)
  end

  def self.permitted_mime_types
    %w(text/plain application/pdf)
  end

  validates :copies, numericality: { only_integer: true }
  validates :duplex, inclusion: { in: %w(two-sided-long-edge one-sided) }
  validates :ranges, format:  { with: /[0-9\-, ]+/, allow_blank: true }
  validate  :media_in_printer
  validate  :file_is_valid
  validates :ppi, inclusion: { in: Print.available_ppi }
  validates :username, :password, :printer, :file, presence: true

  attr_accessor :copies, :duplex, :collate, :ranges, :media, :username, :password, :ppi, :file, :file_cache, :file_name, :printer


  def initialize(attributes = {})
    attributes.each do |name, value|
      send "#{name}=", value
    end
  end

  def options
    [:collate, :duplex, :ranges, :ppi, :media].select{ |o| send o }.map { |opt| "-o #{opt}\='#{send opt}'" }.join " "
  end


  def duplex
    @duplex ? "two-sided-long-edge" : "one-sided"
  end

  def duplex=(duplex_param)
    @duplex = (duplex_param == true || duplex_param == '1')
  end

  def collate
    return "True" if @collate
  end

  def collate=(collate_param)
    if (collate_param == true || collate_param == '1')
      @collate = true
    end
  end


  def persisted?
    false
  end

  def to_s
    "/usr/bin/lpr -P '#{printer.name}' -\# #{copies} #{options}"
  end

  def print_logger(err)
    @@print_logger ||= Logger.new(Rails.root.join('log', 'printer.log'))
    @@print_logger.error "#{err} USER: #{self.username} CMD: \"#{self.to_s}\""
  end

  private
    def media_in_printer
      errors.add(:media, :unsupported) unless printer && printer.media.split.include?(media)
    end

    def file_is_valid
      errors.add(:file, :invalid_type) unless Print.permitted_mime_types.include? mime_type(file)
      errors.add_on_blank(:file) if file.nil? || !File.file?(file)

      errors.add(:file, :invalid) unless File.absolute_path(file).start_with? '/tmp'
    end

    def mime_type(file)
      `file --mime-type -b '#{File.absolute_path(file)}'`.chomp
    end
end
