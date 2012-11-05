Feature: Friendship between users

Background: Users in Database

  Given the following users exist:
  |name |email        |password|password_confirmation|
  |user1|user1@dot.com|foobar  |foobar               |
  |user2|user2@dot.com|barfoo  |barfoo               |
  |user3|user3@dot.com|youbar  |youbar               |

  Scenario: Add user as a friend

    Given I am logged in as "user1"
    Then I should be on profile page for "user1"
