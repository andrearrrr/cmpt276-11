class GroupController < ApplicationController
  def create
    @group = Group.new(params[:group])
end
