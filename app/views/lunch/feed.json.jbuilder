json.cache! ['lunch', Date.today] do
  json.array!(@lunch.feed_entries) do |restaurant|
    json.name restaurant[:name]
    json.meals restaurant[:meals] do |meal|
      json.title meal[:title]
      json.summary meal[:summary]
      json.price meal[:price]
    end
  end
end
