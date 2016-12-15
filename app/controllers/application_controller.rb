class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #attr_accessor :stack
  helper_method :add_job
  helper_method :job_done
  helper_method :initialize_stack
  # Adds a job to a stack

  def add_job(job, params)
  	#params = {user: @user,  ne: ne, job: PingerJob.perform_async }
  	@stack.push([job, params])
  	check_on_stack
  end

  def check_on_stack()

  	status = Job.first[:status]
  	if status == 'done'
  		get_job_done
  	end

  end

  #Gets called once thread finishes completion 
  def get_job_done()
  	#@timein += 5
  	#puts @timein.to_s
	job = @stack[0][0]
	params = @stack[0][1]
	@stack = @stack.drop(1)
  	
  	case
	  when job == 'ping'
	    PingerJob.perform_async(params)
	    #PingerJob.perform_in(@timein, params)
	  when job == 'version'
	    VersionJob.perform_async(params)
	    #VersionJob.perform_in(@timein, params)
	end
  end

  def initialize_stack()
  	@stack = []
  	@timein = 0
  end

end
