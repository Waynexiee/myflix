require 'spec_helper'

describe Category do
  it {should have_many(:videos)}

  describe "#recent_videos" do
    it "returns 6 recently videos if the category has many videos" do
      category = Category.create(name: "Animation")
      3.times do
        Video.create(title: "name", description: "good", category: category)
      end
      6.times do
        Video.create(title: "suck", description: "good", category: category)
      end
      expect(category.recent_videos).to eq(category.videos.first(6))
    end

    it "returns all recent videos if the category has less than 6 videos" do
      category = Category.create(name: "Animation")
      3.times do
        Video.create(title: "name", description: "good", category: category)
      end

      expect(category.recent_videos).to eq(category.videos)
    end

    it "return empty array when category doesn't have any videos" do
      category = Category.create(name: "Animation")
      category1 = Category.create(name: "Ani")
      3.times do
        Video.create(title: "name", description: "good", category: category)
      end

      expect(category1.recent_videos).to eq([])
    end
  end
end
