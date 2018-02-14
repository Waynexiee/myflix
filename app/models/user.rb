class User < ActiveRecord::Base
  validates_presence_of :email, :name, :password
  validates_uniqueness_of :email
  has_secure_password
  has_many :reviews,->{ order(updated_at: :desc) }
  has_many :queue_items, -> { order(:order) }


  def queue_nomalize
    queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(order: index+1)
    end
  end

  def queued_video?(video)
    !!QueueItem.find_by(video_id: video.id)
  end
end
