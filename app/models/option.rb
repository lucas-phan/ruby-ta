class Option < ActiveRecord::Base
	validates :key,
	        presence: true,
	        uniqueness: true 
	validates :value,
	        presence: true
	def to_s
     
	end
end
