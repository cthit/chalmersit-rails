class CalendarController < ApplicationController
  layout false

  def fetch
    @calendar = Calendar.new
  end
end
