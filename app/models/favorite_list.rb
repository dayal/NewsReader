class FavoriteList < ActiveRecord::Base
  belongs_to :users
  has_and_belongs_to_many :articles

  validates :user_id, presence: true, uniqueness: true
end