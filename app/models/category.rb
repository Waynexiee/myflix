class Category < ActiveRecord::Base
  has_many :videos, -> {order("created_at DESC")}, dependent: :destroy

  def recent_videos
    videos.take(6)
  end
end
