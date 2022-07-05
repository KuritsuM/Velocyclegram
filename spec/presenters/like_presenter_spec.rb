require_relative '../rails_helper'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.describe LikePresenter, type: :model do
  let!(:user1) { create :user, :user1 }
  let!(:user2) { create :user, :user4 }
  let!(:user3) { create :user, :user3 }
  let!(:user_post) { create :post, title: "title", user: user3 }
  let!(:like) { create :like, user: user3, post: user_post }

  let!(:like_presenter) { LikePresenter.new(user3.id, user_post.id) }

  it "should return last created post" do
    expect(like_presenter.count_post_likes).to eq(1)
  end

  it "should return like id" do
    expect(like_presenter.user_like_id).to eq(like.id)
  end

  it "should return if user liked post" do
    expect(like_presenter.user_not_liked_post?).to eq(false)
  end
end
