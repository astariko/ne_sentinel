class User < ActiveRecord::Base
	has_many :nes, dependent: :destroy
	has_many :branches, dependent: :destroy
  
  	def ectypes
  		return ['EC', 'ECX', 'ARMADA', 'PSS4', 'ECE']
  	end

end
