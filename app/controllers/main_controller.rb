class MainController < ApplicationController

  skip_before_action :verify_authenticity_token

  def main
    if session[:user_id]
      @user = User.find(session[:user_id])
      redirect_to feed_path
    else
      @user = User.new
    end
  end

  def login
    session[:user_id] = nil
    @user = User.find_by(email: params[:user][:email])
    if (@user && @user.authenticate(params[:user][:password]))
      redirect_to feed_path, notice: "Successfully login."
      session[:user_id] = @user.id
    else
      redirect_to '/main', alert: "Wrong username or password."
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to '/main', notice: "Successfully logout."
  end

  def register
    session[:user_id] = nil
    @user = User.new
  end

  def create_user
    @user = User.new(user_params)

    if @user.save
      redirect_to main_path, notice: "User was successfully created."
    else
      render :register, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
