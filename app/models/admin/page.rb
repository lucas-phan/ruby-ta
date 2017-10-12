class Admin::Page < ActiveRecord::Base
	self.table_name = "pages"
	validates :title,
	        presence: true
	validates :status,
	        presence: true
	validates :slug,
	        presence: true,
	        uniqueness: true        
	def to_s

	end
	 
end
