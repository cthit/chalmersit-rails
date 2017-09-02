module CalendarHelper

  def header
    content_tag :tr do
      Date::DAYNAMES.rotate.map { |day| content_tag :th, day[0].upcase, title: day }.join.html_safe
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
    return content_tag :td, '' if day.nil? || day < @calendar.date.beginning_of_month

    options = {}
    day_events = @calendar.events.select { |e| e[:start] == day.day }

    day_events.each do |event|
      title = day_events.map{ |e| e[:summary].force_encoding('UTF-8') }.join(' ')
      options = { data: { tooltip: '' }, title: title }
    end

    content_tag :td, (content_tag :span, day.day), { class: day_classes(day, day_events.present?) }.merge(options)
  end

  def day_classes(day, has_events)
    classes = []
    classes << "gce-has-events" if has_events
    classes << "gce-day-past" if day < Date.today
    classes << "gce-today" if day == Date.today
    classes << "gce-day-future" if day > Date.today
    classes.empty? ? nil : classes.join(" ")
  end

  def weeks
    first = @calendar.date.beginning_of_month.beginning_of_week(Calendar::START_DAY)
    last = @calendar.date.end_of_month
    (first..last).to_a.in_groups_of(7)
  end

  def calendar
    content_tag :table, class: "gce-calendar" do
      header + week_rows
    end
  end
end
