Feature: Newslists

  As a Newsreader Digest user
  So that I can read news of the same category
  I want to be able to create newslists

Background: Users in database

  Given the following users exist:
  | name  | email              | password | password_confirmation |
  | user1 | myemail@test.com   | 123456   | 123456                |
  | user2 | youremail@test.com | 123456   | 123456                |

  And I am logged in as "user1"
  And I am on the profile page for "user1"
  #Create fake Feeds (Engadget, Wired)

Scenario: Creating a NewsList

  When I safely follow "Create NewsList"
  When I safely fill in "Name" with "Technology"
  And I safely select "Engadget" from "Available Feeds"
  And I safely follow "Create NewsList"
  Then I should safely see "Successfully created NewsList"
  And I should safely see "Technology"

Scenario: Creating a NewsList sadpath: no name

  When I safely follow "Create NewsList"
  And I safely select "Engadget" from "Available Feeds"
  And I safely follow "Create NewsList"
  Then I should safely see "Name can't be blank"

Scenario: Editing a NewsList

  When I safely go to the edit page for "Technology"
  And I safely select "Wired Top Stories" from "Available Feeds"
  And I safely follow "Save Changes"
  Then I should safely see "Successfully updated NewsList"

Scenario: Editing a NewsList sadpath: no name/feeds

  When I safely go to the edit page for "Technology"
  And I safely fill in "Name" with ""
  And I safely follow "Save Changes"
  Then I should safely see "Name can't be blank"

Scenario: Privating a NewsList

  When I safely go to the edit page for "Technology"
  And I safely check "Make Private?"
  And I safely follow "Save Changes"
  Then I should safely see "Successfully updated NewsList"
  Given I am logged in as "user2"
  And I safely go to profile page for "user1"
  Then I should safely not see "Technology"

Scenario: Unprivating a NewsList

  Given I am logged in as "user1"
  When I safely go to the edit page for "Technology"
  And I safely uncheck "Make Private?"
  And I safely follow "Save Changes"
  Then I should safely see "Successfully updated NewsList"
  Given I am logged in as "user2"
  And I safely go to profile page for "user1"
  Then I should safely see "Technology"

Scenario: Viewing another user's newslist

  Given I am logged in as "user2"
  And I safely go to profile page for "user1"
  And I safely follow "Technology"
  Then I should safely be on the show page for "Technology"

Scenario: Attempting to view a private NewsList

  Given I am logged in as "user1"
  And I make "Technology" private
  Then I am logged in as "user2"
  And I should safely go to the show page for "Technology"
  Then I should safely see "You are trying to access a private newslist"
