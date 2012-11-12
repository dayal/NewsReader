class Feed < ActiveRecord::Base
  attr_accessible :feed_url, :string
  after_create :add_article
  has_many :articles

  def self.update_continuously(delay_interval = 15.minutes)
 		Feed.all.each do |feed|
 			feedzirra_feed = Feedzirra::Feed.fetch_and_parse(feed.feed_url)
	    loop do
	      sleep delay_interval
	      feedzirra_feed = Feedzirra::Feed.update(feedzirra_feed)
	      #need to change this in the future, Feedzirra::Feed.update somehow returns an empty array
	      add_articles(feedzirra_feed.new_entries, feed) if feedzirra_feed
	    end
	  end
  end
  
  private

	  def add_article
	  	feedzirra_feed = Feedzirra::Feed.fetch_and_parse(self.feed_url)
		  Feed.add_articles(feedzirra_feed.entries, self)
	 	end

	  def self.add_articles(entries, feed)
	    entries.each do |entry|
	      unless Article.find_by_guid(entry.id)
	        Article.create!(
	        	:feed_id			=> feed.id,
	          :title        => entry.title,
	          :author				=> entry.author,
	          :summary      => entry.summary,
	          :content			=> entry.content,
	          :url          => entry.url,
	          :published_at => entry.published,
	          :guid         => entry.id,
            :image_url    => Article.extract_img(entry.summary)
	        )
	      end
	    end
	  end
end
