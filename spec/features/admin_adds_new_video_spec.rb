require 'spec_helper'

feature 'AdminAddsNewVideo' do
  scenario "Admin successfully add a new video" do
    admin = Fabricate(:admin)
    dramas = Fabricate(:category, name: "Dramas")
    sign_in(admin)
    visit new_admin_video_path

    fill_in "Title", with: "Monk"
    select "Dramas", from: "video_category_id"
    fill_in "Description", with: "Detective"

    attach_file "Large cover", "spec/support/uploads/monk_large.jpg"
    attach_file "Small cover", "spec/support/uploads/monk.jpg"
    fill_in "Video_url", with: "www.youtube.com"
    click_button "Add Video"

    sign_out
    sign_in
    visit video_path(Video.first)
    expect(page).to have_selector("img[src='/uploads/video/larger_cover_url/1/monk_large.jpg']")
  end
end