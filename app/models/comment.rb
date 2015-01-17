class Comment < ActiveRecord::Base
  belongs_to :post, counter_cache: true

  validates :user_id, :body, presence: true
  validates :body, length: { in: 10..500 }

  def user
    @user ||= User.find(user_id)
  end
end
