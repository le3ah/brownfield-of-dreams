class FriendshipsController < ApplicationController
  def create
    new_friend = User.find_by(github_name: params[:github_name])
    if new_friend
      current_user.friends << new_friend
      flash[:notice] = "Added your new Friend!"
    else
      flash[:error] = "Unable to add friend."
    end
    redirect_to dashboard_path
  end
end
