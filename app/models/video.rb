class Video < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  index_name ["myflix", Rails.env].join('_')
  belongs_to :category
  validates_presence_of :description, :title
  has_many :reviews, -> { order(updated_at: :desc) }
  has_many :queue_items
  mount_uploader :smaller_cover_url, PictureUploader
  mount_uploader :larger_cover_url, LargePictureUploader
  def self.search_by_title(title)
    return [] if title.blank?
    Video.where(["title LIKE ?", "%#{title}%"]).order("created_at DESC") || []
  end

  def average_score
    reviews.any? ? reviews.average(:score).to_f.round(1) : 0
  end

  def self.search(query, options={})
    search_definition = {
      query: {
        bool: {
          must: {
            multi_match: {
              query: query,
              fields: ["title^100", "description^50"],
              operator: "and"
            }
          }
        }
      }
    }

    __elasticsearch__.search(search_definition)
  end

  def as_indexed_json(options={})
    as_json(
      only: [:title, :description],
    )
  end

end
