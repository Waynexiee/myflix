class ReviewsController < ApplicationController
  before_action :require_user ,only: [:create]
  def create
    @video = Video.find(params[:video_id])
    @review = @video.reviews.build(review_params)
    if @review.save
      flash[:success] = "You uploaded a successful review."
      redirect_to @video
    else
      @reviews = @video.reviews.reload
      flash.now[:error] = "invlid rate!"
      render "videos/show"
    end
  end

  private

  def review_params
    reviewParams = {}
    reviewParams[:user_id] = session[:user_id]
    reviewParams[:score] = params[:review][:score]
    reviewParams[:content] = params[:review][:content]
    reviewParams
  end
end
