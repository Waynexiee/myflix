class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: User
  validates_presence_of :user, :friend
end
