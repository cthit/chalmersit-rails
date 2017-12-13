class Event < ActiveRecord::Base
  scope :today, -> { where(event_date: Date.today.beginning_of_day..Date.tomorrow.beginning_of_day) }
  validates :event_date, :start_time, :end_time, presence: true, allow_blank: false
  validates_length_of :facebook_link, :maximum => 255, :allow_blank => true
  belongs_to :post

  def start_date
    event_date.to_time.change(hour: start_time.hour, min: start_time.min)
  end
end
