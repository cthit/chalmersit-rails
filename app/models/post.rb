class Post < ActiveRecord::Base
  validates :title, :body, :user_id, presence: true
  validates :title, length: { in: 5..50 }
  validates :body, length: { in: 10..500 }
  validates :sticky, inclusion: { in: [true, false] }

  def previous
    Post.where('id < ?', id).order(id: :desc).first
  end

  def next
    Post.where('id > ?', id).first
  end
end
