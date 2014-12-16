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
    "/usr/bin/lpr -P '#{printer}' -\# #{copies} #{options}"
  end

  def options
    [:duplex, :ranges, :ppi, :media].select{ |o| send o }.map { |opt| "-o #{opt}\='#{send opt}'" }.join " "
  end

  def duplex
    @duplex ? "two-sided-long-edge" : "one-sided"
  end

  def self.available_media
    %w(A3 A4)
  end

  def self.available_ppi
    %w(auto 600 1200)
  end

  validates :copies, numericality: { only_integer: true}
  validates :duplex, inclusion: { in: ["two-sided-long-edge", "one-sided"]}
  validates :ranges, format:  { with: /[0-9\-, ]+/, allow_blank: true}
  validates :media, inclusion: { in: Print.available_media }
  validates :ppi, inclusion: { in: Print.available_ppi }
  validates :username, :password, :file, :printer, presence: true
end
