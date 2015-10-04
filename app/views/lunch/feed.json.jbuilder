json.array! @restaurants do |restaurang|
  json.name restaurang[:name]
  json.meals restaurang[:meals] do |meal|
	json.meal meal[:title]
	json.summary meal[:summary]
  end
end