require 'nokogiri'
class Article < ActiveRecord::Base
	belongs_to :feed
  attr_accessible :guid, :published_at, :summary, :url, :author, :content, :title, :image_url
  def self.extract_img(content)
    doc = Nokogiri::HTML(content)
    img_srcs = doc.css('img').map{ |i| i['src'] }
    img_srcs[0]
  end

  def feed_name
  	this.feed.name
  end
end
