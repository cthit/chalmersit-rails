class Comment < ActiveRecord::Base
  scope :latest_last, -> { order(created_at: :asc) }
  belongs_to :post, counter_cache: true, touch: true
  ar_belongs_to :user

  validates :user_id, :body, presence: true
  validates :body, length: { in: 10..500 }

end
