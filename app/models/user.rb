class User < ActiveRecord::Base
  include Amistad::FriendModel
  
  attr_accessible :email, :name, :password, :password_confirmation, :avatar
  has_secure_password
  has_many :news_lists, dependent: :destroy
  has_one :favorite_list
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  after_create :create_favorite_list
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  has_attached_file :avatar, :styles => { :medium => "100x100>" }
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def create_favorite_list
      self.favorite_list = FavoriteList.create
    end
end
