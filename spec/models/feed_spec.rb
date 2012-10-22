require 'spec_helper'

describe Feed do
	before :each do
		@feed = Feed.create(:feed_url => "http://feeds.feedburner.com/railscasts")
	end

	#can't stop because of the infinite loop
	#@describe 'update feed' do
	#	it 'should call the model method that adds articles if the feed has been updated' do
	#		feedzirra_feed = Feedzirra::Feed.fetch_and_parse(@feed.feed_url)
	#		Feedzirra::Feed.should_receive(:fetch_and_parse).with(@feed.feed_url)
	#		Feedzirra::Feed.should_receive(:update)
	#		Feed.update_continuously(1.second)
	#	end
	#end
		
	describe 'add articles' do
		it 'should create Article entries for each item in the input unless an entry for that article already exists' do
		  feedzirra_feed = Feedzirra::Feed.fetch_and_parse(@feed.feed_url)
			Feed.add_articles(feedzirra_feed.entries)
			entry = feedzirra_feed.entries.first
			Article.first.title.should == entry.title
			Article.first.author.should == entry.author
			Article.first.summary.should == entry.summary
			Article.first.content.should == entry.content
			Article.first.url.should == entry.url
			Article.first.published_at.should == entry.published
			Article.first.guid.should == entry.id
		end
	end
end
