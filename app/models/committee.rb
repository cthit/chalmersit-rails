class Committee < ActiveRecord::Base
  validates :slug, :name, :title, :description, :url, :email, presence: true
  validates :slug, :name, uniqueness: true

  def to_param
    slug
  end
end
