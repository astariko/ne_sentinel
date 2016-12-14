class UsersController < ApplicationController
  before_action :set_user
	# =================================================================
  def index
	# =================================================================
    #@site = 'http://pssnfs-lx.mh.lucent.com/1830wiki/1830PSS_Fruits_G_Deliveries'
    @site = 'http://localhost:3000/users/9/1830'
    @looking_for = "grape-"
		@nes = @user.nes
		@branches = @user.branches
    #Q1. do I need to reping NEs?
    #Q2. do I need to refresh the load?
    for ne in @nes
      time =  (Time.now - ne[:updated_at]).seconds / 60 # minutes
      if time > 15
        PingerJob.perform_async(@user, ne)
        VersionJob.perform_async(@user, ne)
      end
    end
    #Q3. Do I need to reload  release latest load?
  end

  # GET /user/edit
  def edit
  end
  # PATCH/PUT /user/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to root_path, notice: 'User Profile was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end  
	# =================================================================
	def getVersion (system)
	# =================================================================
		@dir = '/home/astariko/APT/aptDev/testcase/ot/encryption/KMT/'
		@command = 'cd ' +@dir + '; python ne_handshake.py --system ' 
							+system + ' --config ne_handshake.cfg'
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.first
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:rootec, :rootecx, :rootece, :rootarmada, :rootpss4)
    end
end
