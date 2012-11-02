Feature: Personal Profile Page

  As a social network users
  So that I am able to connect to other news readers
  I want to have my own personal profile

Background: Some users are already in database

  Given the following users exist:
  |name |email           |
  |user1|myemail@test.com|

  Background: Not logged in and there are users in database
  
    Given I am not logged in

  Scenario: Sign up for new account

    Given I am on the NewsReader Digest home page
    And I follow the Sign Up button
    When I fill in the "Signup" form
    And I follow the "Submit" button
    Then I should be on the NewsReader Digest home page
    And I should see "Account successfully created!"

  Scenario: Unable to view another person's profile

    When I am on the profile page for "user1"
    Then I should see "You must be logged in to view another user's profile"

  Scenario: Should not see Friends' favorited news section on home page

    When I am on the NewsReader Digest home page
    Then I should not see "News Read by Your Friends"

  Scenario: Logging in - user exist

    When I click on the "Log In" button
    And I fill out the login form with correct information
    Then I should be on the NewsReader Digest home page
    And I should see "Successfully logged in."

  Scenario: Logging in - user does not exist

    When I click on the "Log In" button
    And I fill out the login form with incorrect information
    Then I should see the login form
    And I should see "Either your username or password was incorrect, please double check"

  Background: User logged in
  
    Given I am logged in

  Scenario: View another user's profile page

    When I am on the profile page for "user1"
    Then I should see "Name"
    And I should see "Email"
    And I should see other information of that user

  Scenario: Logging out

    When I follow the "Log Out" button
    Then I should be on the NewsReader Digest home page
    And I should see "You have successfully logged out."
    And I should see the "Sign Up" button

  Scenario: Seeing Friends' favorited news

    When I am on the NewsReader Digest home page
    Then I should see "News Read by Your Friends"

  Scenario: Sending friend request

    Given I am on the profile page for "user1"
    And I click on "Send Friend Request"
    Then I should see "Friend Request Successfully Sent"
