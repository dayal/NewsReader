Feature: Personal Profile Page

  As a social network users
  So that I am able to connect to other news readers
  I want to have my own personal profile

Background: Some users are already in database

  Given the following users exist:
  | name  | email              | password | password_confirmation |
  | user1 | myemail@test.com   | 123456   | 123456                |
  | user2 | youremail@test.com | 123456   | 123456                |

  And I am not logged in

Scenario: Sign up for new account

  Given I am on the NewsReader Digest home page
  And I follow "Sign Up"
  When I fill in the Signup form
  And I press "Create Account"
  Then I should be on the profile page for "John Doe"
  And I should see "Welcome to Newsreader Digest!"

Scenario: Unable to view another person's profile

  When I go to the profile page for "user1"
  Then I should see "Only signed in users can access this page. Please sign in."

Scenario: Should not see Friends favorited news section on home page

  When I am on the NewsReader Digest home page
  Then I should not see "News Read by Your Friends"

Scenario: Logging in - user exist

  When I follow "Log In"
  And I fill out the login form with correct information
  Then I should be on the profile page for "user1"
  And I should see "Welcome back, user1!"

Scenario: Logging in - user does not exist

  When I follow "Log In"
  And I fill out the login form with incorrect information
  Then I should be on the login form
  And I should see "Invalid email/password combination"

Scenario: View another user's profile page

  Given I am logged in
  When I am on the profile page for "user1"
  Then I should see "Name"
  And I should see "Email"

Scenario: Logging out

  Given I am logged in
  When I follow "Log Out"
  Then I should be on the NewsReader Digest home page
  And I should see "You have logged out successfully."
  And I should see the "Sign Up" button

Scenario: Seeing Friends favorited news

  Given I am logged in
  When I am on the NewsReader Digest home page
  Then I should see "News Read by Your Friends"

Scenario: Sending friend request

  Given I am logged in
  Given I am on the profile page for "user1"
  And I press "Add Friend"
  Then I should see "Successfully invited friend!"
