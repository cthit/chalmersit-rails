# require 'net/http'
# require 'icalendar'
# require 'icalendar/recurrence'

module CalendarHelper

  def calendar_data(url, date)
    cal_data = Net::HTTP.get(URI.parse(url))
    cals = Icalendar::Calendar.parse cal_data
    calendar = cals.first;
    events = calendar.events

    events = get_events_between calendar, date.beginning_of_month, date.end_of_month
    events.group_by{ |e| e.dtstart.day }

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

  def calendar(url, date = Date.today)
    Calendar.new(self, date, calendar_data(url, date)).table
  end

  class Calendar < Struct.new(:view, :date, :events)
    HEADER = I18n.t(:"date.day_names").rotate
    START_DAY = :monday

    delegate :content_tag, to: :view

    def table
      content_tag :table, class: "gce-calendar" do
        header + week_rows
      end
    end

    def header
      content_tag :tr do
        HEADER.map { |day| content_tag :th, day[0].upcase, title: day }.join.html_safe
      end
    end

    def week_rows
      weeks.map do |week|
        content_tag :tr do
          week.map { |day| day_cell(day) }.join.html_safe
        end
      end.join.html_safe
    end

    def day_cell(day)
      return content_tag :td, '' if day.nil? || day < date.beginning_of_month

      options = {}
      if events[day.day]
        title = events[day.day].map{ |e| e.summary.force_encoding('UTF-8') }.join(' ')
        options = { data: { tooltip: '' }, title: title }
      end

      content_tag :td, (content_tag :span, day.day), { class: day_classes(day) }.merge(options)
    end

    def day_classes(day)
      classes = []
      classes << "gce-has-events" if events[day.day]
      classes << "gce-day-past" if day < Date.today
      classes << "gce-today" if day == Date.today
      classes << "gce-day-future" if day > Date.today
      classes.empty? ? nil : classes.join(" ")
    end

    def weeks
      first = date.beginning_of_month.beginning_of_week(START_DAY)
      last = date.end_of_month
      (first..last).to_a.in_groups_of(7)
    end
  end
end
