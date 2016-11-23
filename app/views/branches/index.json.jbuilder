json.array!(@branches) do |branch|
  json.extract! branch, :id, :name, :completed, :root, :http, :user_id
  json.url branch_url(branch, format: :json)
end
