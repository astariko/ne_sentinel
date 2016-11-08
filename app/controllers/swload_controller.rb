class SwloadController < ApplicationController
	# =================================================================
  def index
	# =================================================================

    @site = 'http://pssnfs-lx.mh.lucent.com/1830wiki/1830PSS_Fruits_G_Deliveries'
    @looking_for = "grape-"
    #findLatestLoad
		#getVersion ('BACKBONE')
		# Create a system that has all NEs.

		ne1 = {:name => 'SAN-5a', :ip => '135.121.44.33', :ectype => 'ARMADA', :version => '17.14-20'}
		ne2 = {:name => 'SAN-6', :ip => '135.121.44.34', :ectype => 'ECX', :version => '17.10-20'}
		ne3 = {:name => 'SAN-7', :ip => '135.121.44.27', :ectype => 'PSS4', :version => '17.12-20'}
		ne4 = {:name => 'SAN-10',:ip => '135.121.44.252', :ectype => 'PSS4', :version => '17.14-40'}
		@nes = [ne1, ne2, ne3, ne4]
		
		for ne in @nes
			ne[:isOnline] = isOnline ne[:ip]
		end

		#render layout: "header.erb"
		
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


	# =================================================================
  def findLatestLoad
	# =================================================================
    #require 'open-uri'
    #require 'nokogiri'
    source = open(@site){|f|f.read}


    doc = Nokogiri::HTML::Document.parse(source)
    lines = doc.css("td").css("p[class='line862'], p[class='line891']").map(&:text)

    results = Array.new

    i = 0
    load_data = nil
    lines.each { |line|
      if line.strip.start_with?(@looking_for)
        if load_data
          results << load_data
        end
        i = 0
        load_data = { :label => line.strip, :data => ''}
  
      elsif load_data
        case i
	  when  0 then load_data[:swp] = line.strip
	  when  1 then load_data[:date] = line.strip
	  #when  2 then load_data[:status] = line.strip
	  else load_data[:data] << line.strip
        end
        i += 1
      end
    }

    # At this point results contain a list of loads. Let's find most recent one, that did not fail.
    res = nil
    results.each{ |result|
      if result[:data].include? "Passed"
        res = result
        break
      end
    }

    @latest_load = res
  end

end
