class Follow < ApplicationRecord
  belongs_to :following, class_name: "User"
  belongs_to :follower, class_name: "User"
  def self::make_followers(user_following_id)
    followers = Follow.where(["following_id = :following_id", { following_id: user_following_id }])
    users = []
    followers.each { |follower| users << User.find_by(id: follower.follower_id) }
    users
  end

  def self::make_followings(user_follower_id)
    followings = Follow.where(["follower_id = :follower_id", { follower_id: user_follower_id }])
    users = []
    followings.each { |following| users << User.find_by(id: following.following_id) }
    users
  end
end
