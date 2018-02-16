class PagesController < ApplicationController
  def front
    if logged_in?
      redirect_to videos_path
    end
  end

  def confirm_password_reset

  end

  def token_expired

  end
end
