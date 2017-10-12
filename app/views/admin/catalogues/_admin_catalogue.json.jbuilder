json.extract! admin_catalogue, :id, :name, :image, :parent, :order, :level, :slug, :created_at, :updated_at
json.url admin_catalogue_url(admin_catalogue, format: :json)