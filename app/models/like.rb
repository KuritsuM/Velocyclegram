class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  def self::user_liked_post?(user_id, post_id)
    !(where(user_id: user_id, post_id: post_id).empty?)
  end

  def self::count_post_likes(post_id)
    where(post_id: post_id).count
  end

  def self::find_by_user_id_and_post_id(user_id, post_id)
    where(user_id: user_id, post_id: post_id).first
  end
end
