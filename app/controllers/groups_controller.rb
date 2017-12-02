class GroupsController < ApplicationController

  def index
    @groups = Group.paginate(page: params[:page])
  end

  def new
    @group = Group.new(params[:group])
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(group_params)
    @group.users << current_user
    if @group.save
      flash[:info] = "Group Created!"
      redirect_to @group
    else
      render 'new'
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

end
