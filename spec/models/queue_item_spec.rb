require 'spec_helper'

describe QueueItem do
  it {should belong_to(:user)}
  it {should belong_to(:video)}
  it {should validate_numericality_of(:order).only_integer}
  describe "#video_title" do
    it "should return the video title" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      item1 = Fabricate(:queue_item, video: video, user: user)
      expect(item1.video_title).to eq(video.title)
    end
  end

  describe "#video_category" do
    it "should return the video category name" do
      category = Fabricate(:category)
      video = Fabricate(:video, category:category)
      user = Fabricate(:user)
      item1 = Fabricate(:queue_item, video: video, user: user)
      expect(item1.video_category).to eq(category.name)
    end
  end

  describe "#video_score" do
    it "should return user's score to this video when review exists" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      review = Fabricate(:review,video: video, user: user, score: 3)
      item1 = Fabricate(:queue_item, video: video, user: user)
      expect(item1.video_score).to eq(review.score)
    end

    it "should return user's score to this video when review doesn't exist" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      item1 = Fabricate(:queue_item, video: video, user: user)
      expect(item1.video_score).to be_nil
    end
  end
end
