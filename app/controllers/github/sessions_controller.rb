class Github::SessionsController < ApplicationController
  def create
    current_user.oauth_token = auth_info[:credentials][:token]
    current_user.uid = auth_info[:uid]
    if current_user.save
      session[:user_id] = current_user.id
    end
    redirect_to dashboard_path
  end

  private
  def auth_info
    request.env["omniauth.auth"]
  end
end
