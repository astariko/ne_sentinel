class BranchesController < ApplicationController
  before_action :set_user
  before_action :set_branch  #, only: [:show, :edit, :update, :destroy]

  # GET /branches
  # GET /branches.json
  def index
    #@branches = @user.branches.all
  end

  # GET /branches/1
  # GET /branches/1.json
  def show
    #@branch = @user.branches.find(params[:branch_id])
  end

  # GET /branches/new
  def new
    @branch = @user.branches.new
  end

  # GET /branches/1/edit
  def edit
    #@branch = @user.branches.find(params[:branch_id])
  end

  # POST /branches
  # POST /branches.json
  def create
    @branch = @user.branches.new(branch_params)

    respond_to do |format|
      if @branch.save
        format.html { redirect_to root_path, notice: 'Branch item was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /branches/1
  # PATCH/PUT /branches/1.json
  def update
    respond_to do |format|
      if @branch.update(branch_params)
        format.html { redirect_to root_path, notice: 'Branch item was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def delete
    #@branch = @user.branches.find(params[:branch_id])
  end
  # DELETE /branches/1
  # DELETE /branches/1.json
  def destroy
    @branch.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Branch item was successfully deleted.' }
    end
  end

  private
    def set_user
      @user = User.first
    end
    # Use callbacks to share common setup or constraints between actions.
    #def set_branch
    #  @branch = Branch.find(params[:id])
    #end
        # Use callbacks to share common setup or constraints between actions.
    def set_branch
      if params.include? :branch_id
        @branch = @user.branches.find(params[:branch_id])
      end
      if params.include? :id
        @branch = @user.branches.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def branch_params
      params.require(:branch).permit(:name, :completed, :root, :http, :user_id)
    end
end
