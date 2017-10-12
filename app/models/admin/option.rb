class Admin::Option < ActiveRecord::Base
	self.table_name = "options"
	validates :key,
	        presence: true,
	        uniqueness: true,
	        format: {
	          with: /\A[a-zA-Z0-9_-_.]+\Z/
	        }
	validates :value,
	        presence: true
	 validates :group,
	        presence: true
	def to_s
 
	end
end

 