class Article < ActiveRecord::Base
  attr_accessible :guid, :name, :published_at, :summary, :url
end
