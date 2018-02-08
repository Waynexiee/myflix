require 'spec_helper'

describe Video do

  it {should belong_to(:category)}
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:description)}

  describe "search_by_title" do
    it "cannot find any video" do
      video1 = Video.create(title: "hello", description: "good")
      video2 = Video.create(title: "twillo", description: "good")
      expect(Video.search_by_title('ff')).to eq([])
    end

    it "finds one video" do
      video1 = Video.create(title: "hello", description: "good")
      video2 = Video.create(title: "twillo", description: "good")
      expect(Video.search_by_title('hello')).to include(video1)
    end

    it 'finds all videos' do
      video1 = Video.create(title: "hello", description: "good")
      video2 = Video.create(title: "twillo", description: "good")
      expect(Video.search_by_title('ll')).to eq([video2,video1])
    end

    it 'returns empty array when search with empty string' do
      video1 = Video.create(title: "hello", description: "good")
      video2 = Video.create(title: "twillo", description: "good")
      expect(Video.search_by_title('')).to eq([])
    end
  end
end
