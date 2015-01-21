class Print
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming


  def self.available_ppi
    %w(auto 600 1200)
  end

  validates :copies, numericality: { only_integer: true }
  validates :duplex, inclusion: { in: ["two-sided-long-edge", "one-sided"] }
  validates :ranges, format:  { with: /[0-9\-, ]+/, allow_blank: true }
  validate  :media_in_printer
  validate  :file_is_valid
  validates :ppi, inclusion: { in: Print.available_ppi }
  validates :username, :password, :printer, presence: true
  validates :file, presence: true, unless: 'file_cache.present?'

  attr_accessor :copies, :duplex, :ranges, :media, :username, :password, :ppi, :file, :file_cache, :file_name, :printer


  def initialize(attributes = {})
    attributes.each do |name, value|
      send "#{name}=", value
    end
  end

  def options
    [:duplex, :ranges, :ppi, :media].select{ |o| send o }.map { |opt| "-o #{opt}\='#{send opt}'" }.join " "
  end

  def duplex
    @duplex ? "two-sided-long-edge" : "one-sided"
  end

  def duplex=(duplex_param)
    @duplex = (duplex_param == true || duplex_param == '1')
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
      # TODO: Validate file type
      return errors.add_on_blank(:file) if file.nil? || !File.file?(file)

      unless File.absolute_path(file).start_with?('/tmp')
        self.file_cache = nil
        self.file_name = nil
        errors.add(:file, :invalid)
      end

    end
end
