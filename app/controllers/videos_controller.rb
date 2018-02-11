class VideosController < ApplicationController
  before_filter :logged_in, only: [:index, :show, :search]
  def index
    @categories = Category.all
    render 'home'
  end

  def show
    @video = Video.find(params[:id])
    @reviews = @video.reviews
  end

  def search
    @videos = Video.search_by_title(params[:search])
  end

  def front

  end

  private

  def logged_in
    redirect_to sign_in_path unless logged_in?
  end
end
