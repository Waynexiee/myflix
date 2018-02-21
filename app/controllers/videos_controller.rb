class VideosController < ApplicationController
  before_action :logged_in, only: [:index, :show, :search]
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

  def advanced_search
    options = {
      reviews: params[:reviews],
      rating_from: params[:rating_from],
      rating_to: params[:rating_to]
    }

    if params[:query]
      @videos = Video.search(params[:query],options).records.to_a
    else
      @videos = []
    end
  end


  private

  def logged_in
    redirect_to sign_in_path unless logged_in?
  end
end
