class NesController < ApplicationController
  before_action :set_user
  before_action :set_ne  #, only: [:show, :edit, :update, :destroy]

	# =================================================================
  def index
	# =================================================================
	#@todo_lists = current_user.todo_lists.paginate(page: params[:page], per_page: 8)
	
	for ne in @nes
		ne[:isonline] = isOnline ne[:ip]
	end
  end

  # GET /nes/new
  def new
  	@ne = @user.nes.new
  end
  # POST /nes
  def create
    @ne = @user.nes.new(ne_params)

    respond_to do |format|
      if @ne.save
        format.html { redirect_to root_path, notice: 'NE item was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # GET /nes/edit
  def edit
  end
  # PATCH/PUT /nes/1
  def update
    respond_to do |format|
      if @ne.update(ne_params)
        format.html { redirect_to root_path, notice: 'NE item was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /nes/1
  def destroy
    @ne.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'NE item was successfully destroyed.' } # todo_items_url
    end
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

	def upgrade
		notice = 'Upgrade request issued successfully'


		command =  "apt runstart ot_encrypt_upgrade_Testcase.py --system " + @ne['system'] + " --une " + @ne['name'] + " --uroot " + @user['rootecx'] + " --uload " + @user['uload'].to_s
		respond_to do |format|
			format.html { redirect_to root_path, notice: command }
		end
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
      params.require(:ne).permit(:name, :ip, :ectype, :system)
    end
end
