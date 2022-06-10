require 'rails_helper'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.describe "Likes", type: :request do
  let!(:user1) { create :user, :user1 }
  let!(:user2) { create :user, :user4 }
  let!(:user3) { create :user, :user3 }
  let!(:user_post) { create :post, title: "title", user: user3 }
  let!(:like) { create :like, user: user3, post: user_post }

  let(:correct_like) { { like: { user_id: user2.id, post_id: user_post.id } } }
  let(:incorrect_like) { { like: { user_id: user2.id, post_id: user_post.id + 200 } } }
  describe "POST /likes" do
    it "should redirect if user isn't authorized" do
      post '/likes', params: correct_like
      expect(response).to redirect_to('/')
    end

    it "should create like" do
      sign_in user2
      post '/likes', params: correct_like
      expect(response).to redirect_to(profile_path(user_post.user.id))
      expect(user2.like.empty?).to be(false)
    end

    it "should not create like if user try create like for another user" do
      sign_in user1
      post '/likes', params: correct_like
      expect(response).to redirect_to(profile_path(user_post.user.id))
      expect(user2.like.empty?).to be(true)
    end
  end

  describe "DELETE /likes" do
    it "should delete like" do
      sign_in user3
      delete like_path(id: like.id)
      expect(response).to redirect_to(profile_path(like.post.user.id))
      expect(user3.like.empty?).to be(true)
    end

    it "should not delete like if user try delete like of another user" do
      sign_in user1
      delete like_path(id: like.id)
      expect(response).to redirect_to(profile_path(like.post.user.id))
      expect(user3.like.empty?).to be(false)
    end
  end
end
