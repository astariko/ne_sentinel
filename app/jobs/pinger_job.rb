class PingerJob 
  include SuckerPunch::Job
  workers 4

  def perform(params)
  	ActiveRecord::Base.connection_pool.with_connection do
  		#Job.first.update_attributes(status: "busy")

	  	#sleep (10)
	  	ne = params[:ne]
	    check = Net::Ping::External.new(ne[:ip])
	   	result = check.ping?
	   	puts "pinging..." + ne[:name]
	   	if ne[:isonline] != result
	   		ne.update_attributes({isonline: result})
	   	end
	   	ne.update_attributes({job_status: Ne::JOB_STATUS[:done] })
	  	#Job.first.update_attributes(status: "done")
  	end

  end
end
