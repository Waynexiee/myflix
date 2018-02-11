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
      QueueItem.find_by(params[:order]).delete
      unless QueueItem.all.empty?
        temp = QueueItem.all.map(&:video)
        QueueItem.delete_all
        temp.each {|e| queue_create(e.id)}
      end
      flash[:success] = "Delete video successfully!"
      redirect_to my_queue_path
    end
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
end
