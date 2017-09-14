class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = current_user
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      flash[:notice] = "Logged in as #{@user.name}"
      redirect_to dashboard_path
    elsif @user
      flash[:notice] = "Incorrect Password for #{@user.name}"
      redirect_to login_path
    else
      flash[:notice] = "Username #{params[:user][:name]} not Registered"
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end