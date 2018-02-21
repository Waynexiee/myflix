class AppMailer < ActionMailer::Base
  def send_welcome_email(user)
    @user = user
    mail to: user.email, from: "info@myflix.com", subject: "Welcome to Myflix!"
  end

  def password_reset(user, reset_token)
    @user = user
    @user.reset_token = reset_token
    mail to: user.email, from: "info@myflix.com", subject: "Password reset"
  end

  def send_invitation_email(user)
    @user = user
    mail to: user.email, from: "info@myflix.com", subject: "Your friend invites you to join Myflix!"
  end
end
