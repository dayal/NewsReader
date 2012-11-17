class NewsList < ActiveRecord::Base
  # attr_accessible :title, :body
  has_and_belongs_to_many :feeds
  attr_accessible :is_private
end
