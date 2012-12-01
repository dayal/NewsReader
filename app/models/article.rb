require 'nokogiri'
class Article < ActiveRecord::Base
	belongs_to :feed
  has_and_belongs_to_many :favorite_lists
  has_and_belongs_to_many :news_lists
  attr_accessible :feed_id, :guid, :published_at, :summary, :url, :author, :content, :title, :image_url
  def self.extract_img(content)
    doc = Nokogiri::HTML(content)
    img_srcs = doc.css('img').map{ |i| i['src'] }
    img_srcs[0]
  end

  def feed_name
  	self.feed.name
  end
end
