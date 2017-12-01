class MembershipsController < ApplicationController


  def join
    @group = Group.find(params[:group_id])
    @membership = current_user.memberships.build(:group_id => params[:group_id])
      if @membership.save
        flash[:notice] = "You have joined this group."
        redirect_to root_url
      else
        flash[:error] = "Unable to join."
        redirect_to root_url
      end
  end
end
