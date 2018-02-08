class User < ActiveRecord::Base
  validates_presence_of :email, :name, :password
  has_secure_password
end
