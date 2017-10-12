class Admin::Resource < ActiveRecord::Base
	self.table_name = "resources"
	validates :value,
	        presence: true
	def to_s

	end
end