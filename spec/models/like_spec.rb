require 'rails_helper'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation

DatabaseCleaner.clean

RSpec.describe Like, type: :model do
  let!(:user1) { create :user, :user1 }
  let!(:user2) { create :user, :user2 }
  let!(:user3) { create :user, :user3 }

  let!(:post) { create :post, title: "title", user: user3 }
  let!(:like1) { create :like, user: user1, post: post }
  let!(:like2) { create :like, user: user2, post: post }

  it "should return true because user liked post" do
    puts Like.all.to_json

    expect(Like.user_liked_post?(user1.id, post.id)).to be(true)
  end

  it "should return false because user doesn't liked post" do
    expect(Like.user_liked_post?(user3.id, post.id)).to be(false)
  end

  it "should count post likes" do
    expect(Like.count_post_likes(post.id)).to be(2)
  end

  it "should return like object" do
    expect(Like.find_by_user_id_and_post_id(user1.id, post.id)).to eq(like1)
  end
end
