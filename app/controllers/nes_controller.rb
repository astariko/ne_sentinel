class NesController < ApplicationController
  before_action :set_user
  before_action :set_ne  #, only: [:show, :edit, :update, :destroy]

	# =================================================================
  def index
  end

  def ping_result
    #needs an actual refresh
    @ne = @user.nes.find(@ne[:id])
    if @ne[:isonline]
      wording = "Online"
    else
      wording = "Out of reach"
    end
    data = {:id => @ne[:id], :ne_status => wording}
    #data = {:id => @ne[:id], :status => time}
    render json: data, status: :ok
  end

  #issue version update to run in background
  def version
    time =  (Time.now - @ne[:updated_at]).seconds / 60 # minutes
    if time > 15
      PingerJob.perform_async(@user, @ne)
    end
    # else old value is left
    render :nothing
  end

  def version_result
    if @ne[:isonline]
      wording = "Online"
    else
      wording = "Out of reach"
    end
    data = {:id => @ne[:id], :status => wording}
    #data = {:id => @ne[:id], :status => time}
    render json: data
  end

  # GET /nes/new
  def new
  	@ne = @user.nes.new
  end
  # POST /nes
  def create
    @ne = @user.nes.new(ne_params)
    @ne.branch_id = getBranchByName(@ne.branch_name).id
    @ne.job_status = Ne::JOB_STATUS[:start]

    @ne.save
    respond_to do |format|
      format.js {flash[:notice] = "NE was created"}
      #params = {user: @user,  ne: @ne }
      #redirect_to your_controller_action_url and return
      #add_job('ping', params)
    end
  end

  # GET /nes/edit
  def edit
  end

  def delete
    #@branch = @user.branches.find(params[:branch_id])
  end
  
  # PATCH/PUT /nes/1
  def update
    # Update NE record with branch_id reference
    branch_id = getBranchByName(ne_params[:branch_name]).id
    branch_param = {}
    if branch_id != nil
      branch_param = {branch_id: branch_id}
    end

    respond_to do |format|
      format.js {flash[:notice] = "NE was updated"}
    end
    @ne.update_attributes(ne_params)
    @ne.update_attributes(branch_param)
  end

  # DELETE /nes/1
  # NOT JS
  def destroy
    @ne.destroy
    #respond_to do |format|
    #  format.js {flash[:notice] = "NE was deleted"}
    #end
    respond_to do |format|
      format.html { redirect_to root_path, notice: "NE was deleted" }
    end
  end

  #==================================================================================================================================================================================

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

	def upgrade
		notice = 'Upgrade request issued successfully'


		command =  "apt runstart ot_encrypt_upgrade_Testcase.py --system " + @ne['system'] + " --une " + @ne['name'] + " --uroot " + @user['rootecx'] + " --uload " + @user['uload'].to_s
		respond_to do |format|
			format.html { redirect_to root_path, notice: command }
		end
	end


  # =================================================================
  def getBranchByName(name)
  # =================================================================
    return @user.branches.find_by(name: name)
  end

  #==================================================================================================================================================================================
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.first
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_ne
      if params.include? :ne_id
        @ne = @user.nes.find(params[:ne_id])
      end
      if params.include? :id
      	@ne = @user.nes.find(params[:id])
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def ne_params
      params.require(:ne).permit(:name, :ip, :ectype, :system, :branch_name)
    end

end
