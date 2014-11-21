json.array!(@posts) do |post|
  json.extract! post, :id, :user_id, :group_id, :title, :body, :sticky
  json.url post_url(post, format: :json)
end
