json.array!(@articles) do |article|
  json.extract! article, :id, :title, :image, :content, :status, :node, :order
  json.url article_url(article, format: :json)
end
