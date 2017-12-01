class GroupsController < ApplicationController

  def index
    @groups = Group.paginate(page: params[:page])
  end

  def new
    @group = Group.new(params[:group])
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:info] = "Group Created!"
      redirect_to group_path(@group.id)
    else
      flash[:info] = "Not Saved?"
      redirect_to root_url
    end

  end

  def show
    @group = Group.find(params[:id])
  end

private
  def group_params
    params.require(:group).permit(:name)
  end

end
