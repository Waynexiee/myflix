class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to confirm_password_reset_path
    else
      flash.now[:error] = "Email address not found"
      render 'new'
    end
  end

  def edit

  end

  def update
    if params[:password].empty?
      @user.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      @user.create_reset_digest
      flash[:success] = "Password has been reset."
      redirect_to videos_path
    else
      render 'edit'
    end
  end

  private

  def valid_user
    unless (@user && @user.authenticated?(params[:id]))
      redirect_to root_url
    end
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def user_params
    params.permit(:password)
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "Password reset has expired."
      redirect_to token_expired_path
    end
  end

end
