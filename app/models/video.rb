class Video < ActiveRecord::Base
  belongs_to :category
  validates_presence_of :description, :title

  def self.search_by_title(title)
    return [] if title.blank?
    Video.where(["title LIKE ?", "%#{title}%"]).order("created_at DESC") || []
  end

end
