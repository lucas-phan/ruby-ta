class Page < ActiveRecord::Base
	validates :title,
	        presence: true
	validates :content,
	        presence: true
	validates :status,
	        presence: true
	def to_s

	end
	extend FriendlyId
  	friendly_id :slug, use: :slugged
end
