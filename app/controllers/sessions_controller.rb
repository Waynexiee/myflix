class SessionsController < ApplicationController
  def new
    redirect_to videos_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      flash.now[:success] = "Welcome,#{user.name}"
      log_in(user)
      redirect_to videos_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
