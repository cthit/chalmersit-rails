class Comment < ActiveRecord::Base
  scope :latest_first, -> { order(created_at: :desc) }
  belongs_to :post, counter_cache: true, touch: true

  validates :user_id, :body, presence: true
  validates :body, length: { in: 10..500 }

  def user
    @user ||= User.find(user_id)
  end
end
