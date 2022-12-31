class UsersController < ApplicationController
  before_action :require_login, only: [:show]

  def new
    @user = User.new
  end

  def show
    @user = User.find(session[:user_id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      redirect_to new_register_path
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :username, :password, :password_confirmation)
  end

  def require_login
    if current_user.nil?
      flash[:alert] = "User must be logged in or registered to access"
      redirect_to root_path 
    end
  end
end
