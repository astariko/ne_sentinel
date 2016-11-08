class NesController < ApplicationController
	# =================================================================
  def index
	# =================================================================

  end

  def new
  end

  def create
  end

	# =================================================================
	def getVersion (system)
	# =================================================================
		@dir = '/home/astariko/APT/aptDev/testcase/ot/encryption/KMT/'
		@command = 'cd ' +@dir + '; python ne_handshake.py --system ' 
							+system + ' --config ne_handshake.cfg'

		# clear file manually ...
		`#{@command}`

		# sort of run checks in background whether it was finished... << That is interesting.
		# OR! run tests on all systems at once.  Each one can write to system_name.txt
			
	end


	# =================================================================
	def isOnline (ip)
	# =================================================================
		cmd = 'ping -c 1 ' + ip	
		result = `#{cmd}`
		words = result.split(' ')
		words.each do |word|
			#packet loss is ....
			return false if word == '100%'
			return true if word == '0%'
		end
		return false
	end

end
