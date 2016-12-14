class VersionJob 
  include SuckerPunch::Job

  def perform(user, ne)
  	#debug station
  	#output = `C:\\Python27\\python.exe C:\\Users\\Temk\\Code\\ne_sentinel_supp\\ne_handshake.py`
  	out, err, status = Open3.capture3('C:\\Python27\\python.exe C:\\Users\\Temk\\Code\\ne_sentinel_supp\\ne_handshake.py')
    #output = %x(command)
   	#return check.ping?
   	match = /(version:.*)/.match(out).to_s

   	version =match.split(':')[1]
   	ne.update_attributes({version: version})
  end
end
