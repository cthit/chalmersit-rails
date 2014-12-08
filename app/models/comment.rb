class Comment < ActiveRecord::Base
  belongs_to :post, counter_cache: true

  validates :user_id, :body, presence: true
  validates :body, length: { in: 10..500 }
end
