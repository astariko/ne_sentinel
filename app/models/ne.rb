class Ne < ActiveRecord::Base
	belongs_to :user
	 
	validates :ip, :presence => true, :uniqueness => true,
  		:format => { :with => Resolv::IPv4::Regex }

  	validates :name, presence: true, :uniqueness => true
  	validates :system, presence: true
end
