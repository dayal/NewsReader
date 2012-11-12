Feature: Favorite Articles

  As a news reader
  So that I can re-read and share articles
  I want to be able to favorite articles

Background: Users and articles in database

  Given the following users exist:
  | name  | email              | password | password_confirmation |
  | user1 | myemail@test.com   | 123456   | 123456                |
  | user2 | youremail@test.com | 123456   | 123456                |

  And I am logged in
  And I am on the profile page for "user1"

  And the following articles exist:
  | title    | content               | author     | url                       | summary           | published_at | id |
  | Article1 | Content for Article1. | Herp Derp  | www.awebsite.com/article1 | Article1 summary. | A Webstie    | 1  |
  | Article2 | Article2's content.   | Derpina A. | www.something.com/2       | Article2 summary. | Something    | 2  |

Scenario: Favoriting an article

  Given I am on the page for "Article1"
  When I press "Add to Favorites"
  Then I should see "'Article1' successfully added to favorites."

Scenario: Privately liking an article

  Given I am on the page for "Article2"
  When I press "Privately Like"
  Then I should see "'Article2' successfully added to private favorites."

Scenario: Viewing a favorite article

  Given I added "Article1" to my favorite articles
  And I added "Article2" to my private favorites
  When I follow "Favorite Articles"					#since I'm on my profile page
  Then I should see "Article1"
  And I should see "Private Favorites"
  And I should see "Article2" under "Private Favorites"
  When I follow "Article1"
  Then I should see "Content for Article1."
  
Scenario: Viewing a friend's favorite articles

  Given I added "Article1" to my favorite articles			#user1 will have added Article1 to favorites
  And I added "Article2" to my private favorites			#user1 will have added Article2 to private favorites
  And I am friends with "user2"
  And I am logged in as "user2"
  And I am on the profile page for "user1"
  Then I should see "user1's Favorite Articles"
  When I follow "user1's Favorite Articles"
  Then I should see "Article1"
  And I should not see "Article2"
