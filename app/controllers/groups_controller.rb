class GroupsController < ApplicationController
before_action :logged_in_user
before_action :group_owner, only: [:edit, :destroy]
  def index
    @groups = Group.paginate(page: params[:page])
  end

  def new
    @group = Group.new(params[:group])
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(group_params)
      flash[:success] = "Group Name Updated"
      redirect_to @group
    else
      render 'edit'
    end
  end

  def create
    @group = Group.new(group_params)
    @group.users << current_user
    @group.owner_id = current_user.id
    if @group.save
      flash[:info] = "Group Created!"
      redirect_to @group
    else
      render 'new'
    end
  end

  def destroy
    @group = Group.find(params[:id])
    if @group.owner_id == current_user.id
      @group.destroy
      flash[:success] = "Group Deleted"
      redirect_to groups_path
    else
      flash[:error] = "Unable to delete Group"
      redirect_to @group
    end
  end

  def show
    @group = Group.find(params[:id])
    @picks = Pick.all
    @awards = Award.all
  end

  def join
    @group = Group.find(params[:id])
    @m = @group.memberships.build(:user_id)
  end

private
  def group_params
    params.require(:group).permit(:name)
  end

  def group_owner
    group = Group.find(params[:id])
		redirect_to(group) unless current_user.id == group.owner_id
	end

end
