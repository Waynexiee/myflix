class InvitationsController < ApplicationController
  def new
    @user = current_user
  end

  def create
    @user = User.find_by(email: params[:invite_email])
    if @user
      @user.send_invitation_email(params_user)
      flash[:info] = "Email has been sent to your friend's email box."
      redirect_to videos_path
    else
      flash.now[:error] = "You are not eligable to invite other friends."
      redirect_to sign_in_path
    end
  end

  private

  def params_user
    user = {}
    user[:name] = params[:name]
    user[:email] = params[:email]
    user[:message] = params[:message]
    return user
  end
end


