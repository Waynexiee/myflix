require 'spec_helper'

feature "User resets password" do
  scenario 'user successfully resets the password' do
    jack = Fabricate(:user)
    visit sign_in_path
    click_link "Reset Password"
    fill_in "Email Address", with: jack.email
    click_button "Send Email"

    open_email(jack.email)
    current_email.click_link("Reset password")

    fill_in "New Password", with: "newpassword"
    click_button "Reset Password"

    expect(page).to have_content("Welcome, #{jack.name}")

    clear_email
  end
end