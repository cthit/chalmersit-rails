class Print
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :copies, :duplex, :ranges, :media, :username, :password, :ppi, :file, :printer

  def initialize(attributes = {})
    attributes.each do |name, value|
      send "#{name}=", value
    end
  end

  def duplex=(duplex_param)
    @duplex = (duplex_param == true || duplex_param == '1')
  end

  def to_s
    "/usr/bin/lpr -P '#{printer.name}' -\# #{copies} #{options}"
  end

  def persisted?
    false
  end

  def options
    [:duplex, :ranges, :ppi, :media].select{ |o| send o }.map { |opt| "-o #{opt}\='#{send opt}'" }.join " "
  end

  def duplex
    @duplex ? "two-sided-long-edge" : "one-sided"
  end

  def self.available_ppi
    %w(auto 600 1200)
  end

  validates :copies, numericality: { only_integer: true}
  validates :duplex, inclusion: { in: ["two-sided-long-edge", "one-sided"]}
  validates :ranges, format:  { with: /[0-9\-, ]+/, allow_blank: true}
  validate :media_in_printer # media, inclusion: { in: printer.media.split }
  validates :ppi, inclusion: { in: Print.available_ppi }
  validates :username, :password, :file, :printer, presence: true


  private
    def media_in_printer
      self.errors[:media] << "not supported by printer" unless printer && printer.media.split.include?(media)
    end
end
