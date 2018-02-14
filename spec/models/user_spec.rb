require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:password) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:queue_items).order(:order) }

  describe "#queued_view?" do
    it "should return true if the video is in the queue" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      item = Fabricate(:queue_item, user: user, video: video)
      expect(user.queued_video?(video)).to be(true)
    end

    it "should return false if the video isn't in the queue" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      expect(user.queued_video?(video)).to be(false)
    end
  end
end
