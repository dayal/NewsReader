Feature: Newslists

  As a Newsreader Digest user
  So that I can read news of the same category
  I want to be able to create newslists

Background: Users in database

  Given the following users exist:
  | name  | email              | password | password_confirmation |
  | user1 | myemail@test.com   | 123456   | 123456                |
  | user2 | youremail@test.com | 123456   | 123456                |

  And I am logged in
  And I am on the profile page for "user1"
  #Create fake Feeds (Engadget, Wired)

Scenario: Creating a NewsList

<<<<<<< HEAD
  When I safely follow "Create NewsList"
=======
  Then I follow "Create NewsList"
>>>>>>> 6ab24b91dd595d54e4818dcb0353ca6d7e6ae97e
  Then I should be on the create NewsList page
  And I should see "Available Feeds"				#or whatever we're gonna call the feeds available for adding to newslists
  When I fill in "Name" with "Technology"
  And I add "Engadget" to "Feeds"				#implent/specify wording after figuring out how feeds are added to newslists
  And I push "Create"
  Then I should be on my user profile page
  And I should see "NewsList successfully created."
  And I should see "Technology"	in the "Your NewsLists" box

Scenario: Creating a NewsList sadpath: no name

  When I follow "Create NewsList"
  And I add "Engadget" to "Feeds"
  And I push "Create"
  Then I should see "NewsLists must be named."

Scenario: Creating a NewsList sadpath: no feeds

  When I follow "Create NewsList"
  And I fill in "Name" with "Technology"
  And I push "Create"
  Then I should see "NewsLists must have at least one feed."

Scenario: Editing a NewsList

  Given I have a "Technology" NewsList
  And I follow "Edit NewsList" for the "Technology" NewsList
  Then I should be on the edit NewsList page for "Technology"
  When I add "Wired" to "Feeds"					#implent/specify wording after figuring out how feeds are added to newslists
  And I fill in "Name" with "Tech"
  And I push "Save Changes"
  Then I should be on the NewsList page for "Tech"		#should this count for checking that the NewsList was renamed?
  And I should see "Changes saved."
  And I should see "Wired" in the "Feeds" box 
  
Scenario: Editing a NewsList sadpath: no name/feeds

  Given I have a "Technology" NewsList
  And I am on the edit NewsList page for "Technology"
  When I fill in "Name" with ""
  And I remove "Engadget" from "Feeds"				#implent/specify wording after figuring out how feeds are added to newslists
  And I push "Save Changes"
  Then I should see "NewsLists must be named."
  And I should see "NewsLists must have at least one feed."

Scenario: Privating a NewsList

  Given I have a "Technology" NewsList
  And I am on the edit NewsList page for "Technology"
  When I check "Make Private"
  And I push "Save Changes"
  And I go to my user profile page
  Then I should see "Private NewsLists"
  And I should see "Technology" under "Private NewsLists"

Scenario: Viewing a friend's NewsList

  Given I have a "Technology" NewsList				#user1 will have the technology newslist
  And I am friends with "user2"
  And I am logged in as "user2"
  And I go to the profile page for "user1"
  Then I should see "Technology"

Scenario: Attempting to view a friend's private NewsList

  Given I have a "Technology" NewsList that is private		#user1 will have the technology newslist
  And I am friends with "user2"
  And I am logged in as "user2"
  And I go to the profile page for "user1"
  Then I should not see "Technology"
