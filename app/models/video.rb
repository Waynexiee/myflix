class Video < ActiveRecord::Base
  belongs_to :category
  validates_presence_of :description, :title
  has_many :reviews, -> { order(updated_at: :desc) }
  has_many :queue_items
  def self.search_by_title(title)
    return [] if title.blank?
    Video.where(["title LIKE ?", "%#{title}%"]).order("created_at DESC") || []
  end

end
