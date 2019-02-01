class UsersController < ApplicationController
  def show
    if current_user.oauth_token
      @repos = Repo.find_all_repos(current_user.oauth_token)
      @followers = Follower.find_all_followers(current_user.oauth_token)
      @following = Following.find_all_following(current_user.oauth_token)
    else
      @repos = nil
      @followers = nil
      @following = nil
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
