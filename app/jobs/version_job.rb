class VersionJob 
  include SuckerPunch::Job

  def perform(params)
  	#debug station
  	#output = `C:\\Python27\\python.exe C:\\Users\\Temk\\Code\\ne_sentinel_supp\\ne_handshake.py`
    ne = params[:ne]
    puts "checking version..." + ne[:name]

  	out, err, status = Open3.capture3('C:\\Python27\\python.exe C:\\Users\\Temk\\Code\\ne_sentinel_supp\\ne_handshake.py')
   	match = /(version:.*)/.match(out).to_s
   	result =match.split(':')[1]
    
    if ne[:version] != result
      ActiveRecord::Base.connection_pool.with_connection do
        ne.update_attributes({version: result})
      end
    end
  end
end
