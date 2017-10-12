json.array!(@admin_resources) do |admin_resource|
  json.extract! admin_resource, :id,  :value, :group
  json.url admin_resource_url(admin_resource, format: :json)
end
