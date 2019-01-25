class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  validates_presence_of :user, :video
  validates_numericality_of :order, only_integer: true
  def video_title
    video.title
  end

  def video_category
    video.category.name
  end

  def video_score
    return nil if user.reviews.empty?
    p user.reviews.find_by(video_id: video.id)
    user.reviews.find_by(video_id: video.id).score
  end
end
