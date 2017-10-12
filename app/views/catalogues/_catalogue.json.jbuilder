json.extract! catalogue, :id, :name, :image, :parent, :order, :level, :slug, :created_at, :updated_at
json.url catalogue_url(catalogue, format: :json)