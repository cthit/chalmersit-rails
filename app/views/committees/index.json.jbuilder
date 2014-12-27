json.array!(@committees) do |committee|
  json.extract! committee, :id, :id, :name, :title, :description, :url, :email
  json.url committee_url(committee, format: :json)
end
