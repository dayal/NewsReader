include SessionsHelper

Given /I am logged in as "(.*)"$/ do |e1|
  @user = User.find_by_name(e1)
  visit signin_path
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
  click_button "Log In"
end

Given /"(.*)" is not my friend$/ do |e1|
  user2 = User.find_by_name(e1)
  @user.friend_with? user2
end
