Feature: Display news from various news networks

	As a news reader
	So that I have a single place to read all my news
	I want to read news from different networks

Background: news has been added to database
	
	# Use FactoryGirls to add a few lists of news to the database
	Given there are some lists of news in the database
	And I am on the news page

Scenario: go to article page
	Then I should see "Presidential Race"
	And I should see "Other News"
	When I follow "Presidential Race"
	Then I should be on the page for "Presidential Race"
        And I should see "Obama and Romney are running for President"

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
