require 'rails_helper'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.describe "Follows", type: :request do
  let!(:user1) { create :user, :user1 }
  let!(:user2) { create :user, :user4 }
  let!(:user3) { create :user, :user3 }
  let!(:follow1) { Follow.create(follower_id: user1.id, following_id: user2.id) }

  let(:follow_param) { { follow: { follower_id: user1.id, following_id: user3.id } } }

  describe "GET /following" do
    it "should return 200" do
      sign_in user1
      get followings_path(id: user1.id)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /following" do
    it "should return 200" do
      sign_in user1
      get followers_path(id: user1.id)
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /follow" do
    it "should create following" do
      sign_in user1
      post "/follow", params: follow_param
      expect(response).to redirect_to(profile_path(user3.id))
      expect(user3.followers.empty?).to be(false)
    end

    it "should not create following if user try it do for another user" do
      sign_in user2
      expect { post "/follow", params: follow_param }.to raise_exception(CanCan::AccessDenied)
      expect(user3.followers.empty?).to be(true)
    end
  end

  describe "DELETE /follow" do
    it "should create following" do
      sign_in user1
      delete follow_path(follow1.id)
      expect(response).to redirect_to(profile_path(user2.id))
      expect(user2.followers.empty?).to be(true)
    end

    it "should not create following if user try it do for another user" do
      sign_in user2
      expect { delete follow_path(follow1.id) }.to raise_exception(CanCan::AccessDenied)
      expect(user2.followers.empty?).to be(false)
    end
  end
end
