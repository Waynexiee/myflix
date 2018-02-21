class Admin::VideosController < ApplicationController
  before_action :require_user
  before_action :require_admin

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:success] = "You have successfully added the video #{@video.title}"
      redirect_to new_admin_video_path
    else
      flash[:error] = "Add video failed!"
      render "new"
    end
  end
  private

  def require_admin
    if !current_user.admin?
      flash[:error] = "You are not admin and not allowed to do it!"
      redirect_to videos_path
    end
  end

  def video_params
    params.require(:video).permit(:category_id, :title, :description, :video_url, :larger_cover_url, :smaller_cover_url)
  end

end