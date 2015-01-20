class Printer < ActiveRecord::Base
  def to_s
    "#{name} at #{location} supports #{media}"
  end
end
