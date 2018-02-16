class AppMailer < ActionMailer::Base
  def send_welcome_email(user)
    @user = user
    mail to: user.email, from: "info@myflix.com", subject: "Welcome to Myflix!"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, from: "info@myflix.com", subject: "Password reset"
  end
end
