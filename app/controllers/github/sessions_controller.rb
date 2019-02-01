class Github::SessionsController < ApplicationController

  def create
    if user = User.from_omniauth(request.env["omniauth.auth"], current_user)
     session[:user_id] = user.id
    end
    redirect_to dashboard_path
  end

end
