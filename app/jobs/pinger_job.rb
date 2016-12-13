class PingerJob 
  include SuckerPunch::Job
  
  def perform(user, ne)
    check = Net::Ping::External.new(ne[:ip])
   	#return check.ping?
   	ne.update_attributes({isonline: check.ping?})
  end
end
