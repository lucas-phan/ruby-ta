json.array!(@admin_options) do |admin_option|
  json.extract! admin_option, :id, :key, :value, :group
  json.url admin_option_url(admin_option, format: :json)
end
