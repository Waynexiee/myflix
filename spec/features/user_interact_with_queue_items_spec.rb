require 'spec_helper'
feature "User interacts with the queue" do
  scenario "User adds and reorders the videos in the queue" do
    jack = Fabricate(:user)
    category = Fabricate(:category)
    video1 = Fabricate(:video, category: category)
    video2 = Fabricate(:video, category: category)
    video3 = Fabricate(:video, category: category)
    sign_in(jack)
    find("a[href='/videos/#{video1.id}']").click
    page.should have_content(video1.title)

    click_on "+ My Queue"

    page.should have_content(video1.title)

    visit video_path(video1)

    page.should_not have_content("+ My Queue")

    add_video_to_queue(video2)

    add_video_to_queue(video3)

    visit my_queue_path
    set_video_order(video1, 5)
    set_video_order(video2, 4)
    set_video_order(video3, 3)

    click_on "Update Instant Queue"
    expect_video_order(video1, 3)
    expect_video_order(video2, 2)
    expect_video_order(video3, 1)
  end
end

def add_video_to_queue(video)
  visit video_path(video)
  click_on "+ My Queue"
end

def set_video_order(video, set_order)
  fill_in "item#{video.id}", with: set_order
end

def expect_video_order(video, set_order)
  expect(find("#item#{video.id}").value).to eq(set_order.to_s)
end