json.array!(@users) do |user|
  json.extract! user, :id, :username, :password, :firstname
  json.url user_url(user, format: :json)
end
