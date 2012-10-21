class Article < ActiveRecord::Base
  attr_accessible :guid, :published_at, :summary, :url, :author, :content, :title

end
