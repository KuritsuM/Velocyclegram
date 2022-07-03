class LikePresenter
  def initialize(user_id, post_id)
    @user_id = user_id
    @post_id = post_id
  end

  def user_not_liked_post?
    Like.where(user_id: @user_id, post_id: @post_id).empty?
  end

  def count_post_likes
    Like.where(post_id: @post_id).count
  end

  def user_like_id
    Like.where(user_id: @user_id, post_id: @post_id).first.id
  end
end