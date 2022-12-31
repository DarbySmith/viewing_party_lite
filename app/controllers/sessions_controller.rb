class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      redirect_to login_path
      flash[:error] = "Sorry, your credentials are bad."
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end
end