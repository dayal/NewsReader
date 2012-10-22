Feature: Display news from various news networks

	As a news reader
	So that I have a single place to read all my news
	I want to read news from different networks

Background: news has been added to database
  
  Given I am on the NewsReader Digest home page

Scenario: go to an article page
  Then I should see "Refresh Roundup: week of October 15th, 2012"
  And I should see "Switched On: Sell the hardware, attract the apps"
  When I follow "Refresh Roundup: week of October 15th, 2012"
  Then I should be on the page for "Refresh Roundup: week of October 15th, 2012"
  And I should see "Zachary Lutz"

#Scenario: switch among newslists
#	When I press "Newslist2"
#	Then I should see "The San Francisco Games Revolution Is Over"
#	And I should not see "Watch Felix Baumgartner Live: This Scientific Discovery Brought To You By Mentos, The Freshmaker"
#	When I press "Newslist1"
#	Then I should see "Watch Felix Baumgartner Live: This Scientific Discovery Brought To You By Mentos, The Freshmaker"
#	And I should not see "The San Francisco Games Revolution Is Over"
#
#Scenario: view friends news
#	#not sure how this will be implemented yet
#	Given I have some friends who have shared some news
#	Then I should see the recent news shared by my friends
#
#Scenario: go to profile page
#	When I press "Profile Page"
#	Then I should be on the profile page
#
#Scenario: go to newslist pasge
#	When I press "Add Newslist"
#	Then I should be on the newslist page
