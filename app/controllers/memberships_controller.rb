class MembershipsController < ApplicationController


  def join
    @group = Group.find(params[:group_id])
    @membership = current_user.memberships.build(:group_id => params[:group_id])
      if @membership.save
        flash[:notice] = "You have joined this group."
        redirect_to group_path(@group)
      else
        flash[:error] = "Unable to join."
        redirect_to group_path(@group)
      end
  end

  def leave
    group = Group.find(params[:group_id])
    current_user.groups.delete(group)
    redirect_to group_path(group)
    flash[:notice] = "You have left the group."
  end
end
