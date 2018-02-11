class Review < ActiveRecord::Base
  validates :content, presence:true
  belongs_to :user
  belongs_to :video
end
