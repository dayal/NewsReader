class NewsList < ActiveRecord::Base
  has_and_belongs_to_many :feeds
  attr_accessible :is_private, :name, :feeds
  attr_accessor :feeds_url

  validates :user_id, presence: true
end
