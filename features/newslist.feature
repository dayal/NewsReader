Feature: NewsLists

  As a news reader
  So that I can re-read and share articles
  I want to be able to add articles to NewsLists

Background: Users and articles in database

  Given the following users exist:
  | name  | email              | password | password_confirmation |
  | user1 | myemail@test.com   | 123456   | 123456                |
  | user2 | youremail@test.com | 123456   | 123456                |

  And I am logged in as "user1"
  And I am on the profile page for "user1"

  And the following articles exist:
  | title    | content               | author     | url                       | summary           | published_at | id |
  | Article1 | Content for Article1. | Herp Derp  | www.awebsite.com/article1 | Article1 summary. | 2012-11-16 17:17:00    | 1  |
  | Article2 | Article2's content.   | Derpina A. | www.something.com/2       | Article2 summary. | 2012-11-16 17:17:00   | 2  |

Scenario: Creating a NewsList

  When I safely follow "Create NewsList"
  When I safely fill in "Name" with "Technology"
  And I safely follow "Create NewsList"
  Then I should safely see "Successfully created NewsList"
  And I should safely see "Technology"

Scenario: Adding an article to a created NewsList

  Given I am on the page of article named "Article1"
  And I have created the NewsList "Favorites"
  When I safely select "Favorites" from "Add to NewsList"
  Then I should safely see "'Article1' successfully added to Favorites."

Scenario: Adding an article to an uncreated NewsList

  Given I am on the page of article named "Article2"
  When I safely selct "Create NewsList" from "Add to NewsList"
  Then I should be on the Create NewsList page
  When I enter "Entertainment" for "Name"
  And I safely follow "Create NewsList"
  Then I should safely see "'Article2' successfully added to Entertainment."

Scenario: Editing a NewsList

  Given I am on the Edit page for "Entertainment"
  When I click "Delete" next to "Article2"
  Then I should safely see "Article deleted from NewList"

Scenario: Renaming a NewsList

  Given I am on the edit page for "Entertainment"
  When I fill in "Celebrities" for "Name"
  And I safely follow "Save Changes"
  Then I should see "Successfully updated NewsList."

Scenario: Viewing another user's NewsList

  Given I am logged in as "user2"
  And I safely go to profile page for "user1"
  And I safely follow "Technology"
  Then I should safely be on the show page for "Technology"

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

Scenario: Attempting to view a private NewsList

  Given I make "Technology" private
  And I am logged in as "user2"
  When I safely go to the show page for "Technology"
  Then I should safely see "You are trying to access a private feedslist"

Scenario: Viewing an article from a NewsList

  Given I added "Article1" to "Favorites"
  When I safely follow "Favorites"
  And I safely follow "Article1"
  Then I should safely see "Content for Article1."
  
Scenario: Viewing a friend's articles from a NewsList

  Given I added "Article1" to my favorite articles
  And I am friends with "user2"
  And I am logged in as "user2"
  And I am on the profile page for "user1"
  And I safeley follow "Favorites"
  Then I should safely see "Article1"
