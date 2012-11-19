Feature: Favorite Articles

  As a news reader
  So that I can re-read and share articles
  I want to be able to favorite articles

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

Scenario: Favoriting an article

  Given I am on the page of article named "Article1"
  When I safely follow "Add to Favorite"
  Then I should safely see "'Article1' successfully added to favorites."

#Scenario: Privately liking an article

#  Given I am on the page of article named "Article2"
#  When I press "Privately Like"
#  Then I should see "'Article2' successfully added to private favorites."

Scenario: Viewing a favorite article

  Given I added "Article1" to my favorite articles
  #And I added "Article2" to my private favorites
  When I safely follow "Favorite Articles"
  Then I should safely see "Article1"
  #And I should see "Private Favorites"
  #And I should see "Article2" under "Private Favorites"
  When I safely follow "Article1"
  Then I should safely see "Content for Article1."
  
Scenario: Viewing a friend's favorite articles

  Given I added "Article1" to my favorite articles
  #And I added "Article2" to my private favorites
  And I am friends with "user2"
  And I am logged in as "user2"
  And I am on the profile page for "user1"
  Then I should safely see "Article1"
  And I should not see "Article2"
