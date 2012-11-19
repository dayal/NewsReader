include SessionsHelper
require 'rack_session_access/capybara'

Given /I am logged in as "(.*)"$/ do |e1|
  visit signin_path
  @user = User.find_by_name(e1)
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
  click_button "Log In"
end

Given /"(.*)" is not my friend$/ do |e1|
  user2 = User.find_by_name(e1)
  @user.friend_with? user2
end

When /I safely go to profile page for "(.*)"$/ do |e1|
  step %Q{
    Given I am logged in as "#{@user.name}"
  }
  user2 = User.find_by_name(e1)
  visit user_path(user2)
end

When /I should safely see "(.*)"$/ do |e1|
  step %Q{
    Given I am logged in as "#{@user.name}"
    Then I should see "#{e1}"
  }
end

When /I safely follow "(.*)"$/ do |e1|
  step %Q{
    Given I am logged in as "#{@user.name}"
    And I follow "#{e1}"
  }
end

Given /^I am friends with "(.*?)"$/ do |arg1|
  step %Q{I am logged in as "user1"}
  step %Q{I safely go to profile page for "#{arg1}"}
  step %Q{I should safely see "Add Friend"}
  step %Q{I safely follow "Add Friend"}
end

