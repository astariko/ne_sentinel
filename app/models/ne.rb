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
		check = Net::Ping::External.new(self.ip.to_s)
    	if check.ping?
    		return "Online"
    	else
    		return "Offline"
    	end
	end
end
