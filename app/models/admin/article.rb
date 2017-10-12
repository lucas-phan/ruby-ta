class Admin::Article < ActiveRecord::Base
	self.table_name = "articles"
	validates :title,
	        presence: true
	def to_s

	end
end
