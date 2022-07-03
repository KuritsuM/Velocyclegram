class FollowingsService
  def initialize(user_id)
    @user_id = user_id
  end

  def make_followings
    followings = Follow.where(follower_id: @user_id)
    users = []
    followings.each { |following| users << following.following }
    users
  end
end