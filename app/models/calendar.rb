class Calendar
  START_DAY = :monday

  attr_accessor :url, :date

  def initialize(url=Configurable.calendar_url , date=Date.today)
    @url = url
    @date = date
  end

  def cache_key
    "calendar/#{I18n.locale}/#{@date}"
  end

  def cache_present?
    Rails.cache.exist? self
  end

  def events
    @events ||= Rails.cache.fetch self, expires_in: 1.hour do
      calendar_data
    end
  end

  private
    def calendar_data
      cal_data = Net::HTTP.get(URI.parse(self.url))
      cals = Icalendar.parse cal_data
      calendar = cals.first;
      events = calendar.events

      events = get_events_between calendar, @date.beginning_of_month, @date.end_of_month
      events.group_by{ |e| e.dtstart.day }

      events.map! do |event|
        {start: event.dtstart.day, end: event.dtend.day, summary: event.summary}
      end

    end

    def get_events_between(calendar, first, last)
      new_calendar = Icalendar::Calendar.new

      for event in calendar.events

        recurring_events = event.occurrences_between(first, last)
        for recurring_event in recurring_events
          new_event = Icalendar::Event.new
          new_event.dtstart = recurring_event.start_time
          new_event.dtend = recurring_event.end_time
          new_event.summary = event.summary
          new_calendar.add_event(new_event)
        end
      end
      events = new_calendar.events;
    end
end
