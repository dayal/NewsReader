Feature: Friendship between users

Background: Users in Database

  Given the following users exist:
  |name |email        |password|password_confirmation|
  |user1|user1@dot.com|foobar  |foobar               |
  |user2|user2@dot.com|barfoo  |barfoo               |
  |user3|user3@dot.com|youbar  |youbar               |

  Scenario: Add user as a friend

    Given I am logged in as "user1"
    And I safely go to profile page for "user2"
    Then I should safely see "Add Friend"
    When I safely follow "Add Friend"
    Then I should safely see "Successfully invited friend"

  Scenario: Accepting friend request

    Given I am logged in as "user2"
    Then I should safely see "You have friend requests!"
    When I safely follow "Confirm?"
    Then I should safely see "Successfully confirmed friend!"

  Scenario: Delete a friend

    Given I am logged in as "user1"
    And I safely go to profile page for "user2"
    Then I should safely see "Delete Friend"
    When I safely follow "Delete Friend"
    Then I should safely see "Successfully removed friend!"

  Scenario: Viewing pending friend requests

    Given I am logged in as "user1"
    And I have added "user2" as a friend
    And I am on the profile page for "user1"
    Then I should see "user2" under "Your Friend Requests"

  Scenario: Viewing accepted friend requests

    Given I am logged in as "user1"
    And I have added "user2" as a friend
    And "user2" has accepted my friend request
    And I am on the profile page for "user1"
    Then I should not see "user2" under "Your Friend Requests"

  Scenario: Viewing rejected friend requests

    Given I am logged in as "user1"
    And I have added "user3" as a friend
    And "user3" has rejected my friend request
    And I am on the profile page for "user1"
    Then I should not see "user3" under "Your Friend Requests"
