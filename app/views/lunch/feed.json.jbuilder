json.array!(@lunch.feed_entries) do |entry|
  json.title entry[:title]
  json.summary entry[:summary]
end
