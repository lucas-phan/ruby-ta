json.array!(@admin_articles) do |admin_article|
  json.extract! admin_article, :id, :title, :image, :content, :status, :node, :order
  json.url admin_article_url(admin_article, format: :json)
end
