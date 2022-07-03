class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_writer :login

  has_many :followings, class_name: 'Follow', foreign_key: :follower_id
  has_many :followers, through: :followings
  has_many :followers, class_name: 'Follow', foreign_key: :following_id
  has_many :post
  has_many :commentary
  has_many :like
  has_one_attached :avatar

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true

  # for pagination
  self.per_page = 10

  # returns login
  def login
    @login || self.username || self.email
  end

  # allows use username as user identification via login
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(["username = :value OR email = :value", { :value => login }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  # returns avatar if has else default asset
  def avatar
    if super.attached?
      return super
    end
    "no-avatar.png"
  end
end
