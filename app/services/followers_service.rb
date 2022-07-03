class FollowersService
  def initialize(user_id)
    @user_id = user_id
  end

  def make_followers
    followers = Follow.where(following_id: @user_id)
    users = []
    followers.each { |follower| users << follower.follower }
    users
  end
end