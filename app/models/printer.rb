class Printer < ActiveRecord::Base
  scope :weighted, -> { order(weight: :desc, name: :asc) }
  scope :available, -> { where(deleted: false) }

  def to_s
    "#{name} at #{location} supports #{media}"
  end
end
