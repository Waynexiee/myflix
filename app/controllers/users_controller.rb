class UsersController < ApplicationController
  before_action :require_user ,only: [:show]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_param)
    if @user.save
      AppMailer.send_welcome_email(@user).deliver
      redirect_to sign_in_path
    else
      flash[:failure] = "Your input is invalid!"
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_param
    params.require(:user).permit(:email, :name, :password)
  end
end
