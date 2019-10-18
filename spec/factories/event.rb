FactoryBot.define do
  factory :event do |f|
    event_date { Date.today.tomorrow }
    full_day { false }
    start_time { Time.now + 1.hour }
    end_time { Time.now + 2.hours }
    location { 'Hubben 2.1' }
    organizer { 'smurfarna' }
    association :post
    facebook_link { 'facebook.com/events/...' }
  end
end
