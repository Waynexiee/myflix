class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  validates_presence_of :user, :video
  def video_title
    video.title
  end

  def video_category
    video.category.name
  end

  def video_score
    return nil if user.reviews.empty?
    user.reviews.find(video).score
  end
end
