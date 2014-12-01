class Committee < ActiveRecord::Base
  def to_param
    slug
  end
end
