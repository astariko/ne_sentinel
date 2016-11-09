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
  	#@todo_list = current_user.todo_lists.ne
  	#@ne = nes.new
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.first
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_ne
      if params.include? :id
        @ne = @user.nes.find(params[:id])
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    #def todo_list_params
    #  params.require(:todo_list).permit(:list_name, :list_due_date)
    #end

end
