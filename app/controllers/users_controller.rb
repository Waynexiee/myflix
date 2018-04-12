class UsersController < ApplicationController
  before_action :require_user ,only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_param)
    if @user.valid?
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      charge = StripeWrapper::Charge.create(
        :amount => 999,
        :description => "SIGN IN CHARGE",
        :card => params[:stripeToken],
      )

      if charge.successful?
        @user.save
        AppMailer.delay.send_welcome_email(@user)
        flash[:success] = "Thanks for registering MyFlix, please sign in now."
        redirect_to sign_in_path
      else
        flash.now[:error] = charge.error_message
        render 'new'
      end
    else
      flash.now[:error] = "Your input is invalid!"
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
