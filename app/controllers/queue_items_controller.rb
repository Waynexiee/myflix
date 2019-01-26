class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @queue_items = current_user.queue_items || []
  end

  def create
    @item = queue_add(params[:video_id])
    if not_duplicated?(@item) && @item.save
      flash[:success] = "Add video to queue successfully!"
      redirect_to my_queue_path
    else
      flash.now[:error] = "Add failed!"
      @video = Video.find(params[:video_id])
      render "videos/show"
    end
  end

  def destroy
    if params[:user_id].to_i != current_user.id
      flash.now[:error] = "Delete failed!"
      @queue_items = current_user.queue_items || []
      render "index"
    else
      QueueItem.find_by(order: params[:order].to_i, user_id: params[:user_id].to_i).delete
      current_user.queue_nomalize
      flash[:success] = "Delete video successfully!"
      redirect_to my_queue_path
    end
  end

  def update_queue
    begin
      update_rating
      queue_reorder
      current_user.queue_nomalize
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "Invalid input!"
    end
    redirect_to my_queue_path
  end

  private

  def next_id
    QueueItem.count + 1
  end

  def not_duplicated?(item)
    !current_user.queue_items.map(&:video).include?(item.video)
  end

  def queue_add(id)
    QueueItem.new(order: next_id, video_id: id, user: current_user )
  end

  def queue_create(id)
    QueueItem.create(order: next_id, video_id: id, user: current_user )
  end

  def queue_reorder
    ActiveRecord::Base.transaction do
      params[:queue_items].each do |queue_item|
        item = QueueItem.find(queue_item["id"])
        item.update_attributes!(order: queue_item["order"]) if item.user == current_user
      end
    end
  end

  def update_rating
    params[:queue_items].each do |queue_item|
      item = QueueItem.find(queue_item["id"].to_i)
      reviews = item.user.reviews.where(video_id: item.video.id)
      reviews.each do |review|
        if review.user == current_user
          p review
          review.update_attributes!(score: queue_item["score"].to_i)
        end
      end
    end
  end
end
