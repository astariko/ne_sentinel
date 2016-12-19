class UsersController < ApplicationController
  before_action :set_user
  helper_method :add_job
	# =================================================================
  def index
	# =================================================================
    #@site = 'http://pssnfs-lx.mh.lucent.com/1830wiki/1830PSS_Fruits_G_Deliveries'
    @nes = @user.nes
		@branches = @user.branches
    #Q1. do I need to reping NEs?
    #Q2. do I need to refresh the load?
    initialize_stack()
    if not db_up_to_date?
      for ne in @nes
        params = {user: @user,  ne: ne }
        ne.update_attributes({job_status: Ne::JOB_STATUS[:start] })
        add_job('ping', params)
        #add_job('version', params)
      end
    else
      # if previous session ended badly > overwrite :job_status
      for ne in @nes
        if ne[:job_status] != Ne::JOB_STATUS[:done]
          #ne.update_attributes({job_status: Ne::JOB_STATUS[:done] })
          params = {user: @user,  ne: ne }
          add_job('ping', params)
        end
      end
    end

  end
  #for branch in @branches
  #  site = 'http://localhost:3000/users/9/1830'
  #  looking_for = "grape-"
  #  BranchUpdateJob.perform_async(@user, branch, site, looking_for)
  #end
  #Q3. Do I need to reload  release latest load?
  def job_performing?
    for ne in @nes
      if ne[:job_status] == Ne::JOB_STATUS[:start]
        return true
      end
    end
    return false
  end

  def db_up_to_date?
    for ne in @nes
      time =  (Time.now - ne[:updated_at]).seconds / 60 # minutes
      #Did enough time pass?
      if time > 10
        return false
      end
    end
    return true
  end

  def add_job(job, params)
    #params = {user: @user,  ne: ne, job: PingerJob.perform_async }
    #First let's show user the page. then we'll come back to the stack
    @@stack.push([job, params])
  end

  # many jobs here.
  def check_on_server()
    #puts 'check_on_server()'
    #job_status = Job.first['status']
    #refresh
    @nes = @user.nes
    job_performing= job_performing?

    if not job_performing and db_up_to_date?
      render json: nil, status: :ok
      #respond_to do |format|
      #    format.html { redirect_to root_path }
      #end
    else
      if @@stack.length() > 0
        check_on_stack()
        #service_unavailable
        render json: nil, status: :service_unavailable
      else
        render json: nil, status: :service_unavailable
      end
    end
  end

  def check_on_stack()
    #Job.first.update_attributes(status: "busy")
    #status = Job.first[:status]
    #if status == 'done'
    for pair in @@stack
      params = pair[1]
      job = pair[0]
      case
      when job == 'ping'
        PingerJob.perform_async(params)
        #PingerJob.perform_in(@timein, params)
      when job == 'version'
        VersionJob.perform_async(params)
        #VersionJob.perform_in(@timein, params)
    end
    end
    initialize_stack()
    #Job.first.update_attributes(status: "done")
  end


  def initialize_stack()
    @@stack = []
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
