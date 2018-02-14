require 'spec_helper'
feature "User signs in" do
  scenario "with existing user" do
    jack = Fabricate(:user)
    sign_in(jack)
    page.should have_content "Welcome"
  end
end