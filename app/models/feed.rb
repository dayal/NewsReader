class Feed < ActiveRecord::Base
  attr_accessible :feed_url, :string
  after_create :add_article

  def self.update_continuously(delay_interval = 15.minutes)
 		Feed.all.each do |feed|
	    feedzirra_feed = Feedzirra::Feed.fetch_and_parse(feed.feed_url)
	    add_articles(feedzirra_feed.entries)
	    loop do
	      sleep delay_interval
	      feedzirra_feed = Feedzirra::Feed.update(feedzirra_feed)
	      add_articles(feedzirra_feed.new_entries) if feedzirra_feed.updated?
	    end
	  end
  end
  
  private

	  def add_article
	  	feedzirra_feed = Feedzirra::Feed.fetch_and_parse(self.feed_url)
		  Feed.add_articles(feedzirra_feed.entries)
	 	end

	  def self.add_articles(entries)
	    entries.each do |entry|
	      unless Article.find_by_guid(entry.id)
	        Article.create!(
	          :title        => entry.title,
	          :author				=> entry.author,
	          :summary      => entry.summary,
	          :content			=> entry.content,
	          :url          => entry.url,
	          :published_at => entry.published,
	          :guid         => entry.id
	        )
	      end
	    end
	  end
end
