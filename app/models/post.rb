class Post < ActiveRecord::Base
  scope :ordered, -> { order(created_at: :desc) }

  has_many :comments, dependent: :destroy

  validates :title, :body, :user_id, presence: true
  validates :title, length: { in: 5..50 }
  validates :body, length: { in: 10..500 }
  validates :sticky, inclusion: { in: [true, false] }
  validates :slug, uniqueness: true, presence: true

  before_validation :generate_slug

  def previous
    Post.where('id < ?', id).order(id: :desc).first
  end

  def next
    Post.where('id > ?', id).first
  end

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= title.parameterize
  end
end
