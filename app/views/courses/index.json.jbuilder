json.array!(@courses) do |course|
  json.extract! course, :id, :code, :name, :year, :required, :homepage, :period, :programme, :description
  json.url course_url(course, format: :json)
end
