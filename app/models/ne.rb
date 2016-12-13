class Ne < ActiveRecord::Base
	belongs_to :user
	 
	validates :ip, :presence => true, :uniqueness => true,
  		:format => { :with => Resolv::IPv4::Regex }

  	validates :name, presence: true, :uniqueness => true
  	validates :system, presence: true
  	validates :branch_name, presence: true
  	validates :ectype, presence: true

  	# =================================================================
	def isOnline ()
	# =================================================================
		#check = Net::Ping::External.new(self.ip.to_s)
    	#return check.ping?

    	#return PingerJob.new.perform(self.ip.to_s)
	end
end
