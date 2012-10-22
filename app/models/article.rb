require 'nokogiri'
class Article < ActiveRecord::Base
  attr_accessible :guid, :published_at, :summary, :url, :author, :content, :title
  def self.extract_img(content)
    doc = Nokogiri::HTML(content)
    img_srcs = doc.css('img').map{ |i| i['src'] }
    img_srcs[0]
  end
end
