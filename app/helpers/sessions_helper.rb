module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def log_out
    session[:user_id] = nil
    @current_user = nil
  end

  def require_user
    redirect_to sign_in_path unless logged_in?
  end
end
