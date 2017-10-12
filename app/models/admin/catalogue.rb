class Admin::Catalogue < ActiveRecord::Base
	self.table_name = "catalogues"
	validates :name,
	        presence: true
	validates :slug,
	        presence: true,
	        uniqueness: true 
	def to_s

	end
end
