class Printer < ActiveRecord::Base
  scope :weighted, -> { order(weight: :desc, name: :asc) }

  def to_s
    "#{name} at #{location} supports #{media}"
  end
end
