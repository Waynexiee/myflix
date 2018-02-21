def sign_in(user = nil)
  visit sign_in_path
  user ||= Fabricate(:user)
  fill_in "Email Address", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def sign_out
  click_link "Sign Out"
end

def set_current_user(user = nil)
  session[:user_id] = (user || Fabricate(:user)).id
end

def set_current_admin(admin=nil)
  session[:user_id] = (admin || Fabricate(:admin)).id
end