class GroupsController < ApplicationController

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(params[:name])
    redirect_to root_url
  end

  def show
    @group = Group.find(params[:id])
  end
end
